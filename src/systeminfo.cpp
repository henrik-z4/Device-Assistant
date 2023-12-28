#define _WIN32_DCOM
#include <iostream>
#include <comdef.h>
#include <Wbemidl.h>
#include "systeminfo.h"

#pragma comment(lib, "wbemuuid.lib")

void initializeCOM(HRESULT& hres, IWbemLocator*& pLoc, IWbemServices*& pSvc) {
    // Инициализация COM.
    hres = CoInitializeEx(0, COINIT_MULTITHREADED);
    if (FAILED(hres))
    {
        std::cout << "Ошибка при инициализации COM. Error code = 0x" << std::hex << hres << std::endl;
        return;
    }

    // Настройка уровня безопасности COM.
    hres = CoInitializeSecurity(
        NULL,
        -1,
        NULL,
        NULL,
        RPC_C_AUTHN_LEVEL_DEFAULT,
        RPC_C_IMP_LEVEL_IMPERSONATE,
        NULL,
        EOAC_NONE,
        NULL);

    if (FAILED(hres))
    {
        std::cout << "Ошибка при настройке безопасности COM. Error code = 0x" << std::hex << hres << std::endl;
        CoUninitialize();
        return;
    }

    // Получение указателя на службу WMI.
    hres = CoCreateInstance(
        CLSID_WbemLocator,
        0,
        CLSCTX_INPROC_SERVER,
        IID_IWbemLocator, (LPVOID*)&pLoc);

    if (FAILED(hres))
    {
        std::cout << "Ошибка при создании экземпляра IWbemLocator. Error code = 0x" << std::hex << hres << std::endl;
        CoUninitialize();
        return;
    }

    // Подключение к пространству имен WMI.
    hres = pLoc->ConnectServer(
        _bstr_t(L"ROOT\\CIMV2"),
        NULL,
        NULL,
        0,
        NULL,
        0,
        0,
        &pSvc);

    if (FAILED(hres))
    {
        std::cout << "Ошибка при подключении к пространству имен WMI. Error code = 0x" << std::hex << hres << std::endl;
        pLoc->Release();
        CoUninitialize();
        return;
    }

    // Установка уровня безопасности для прокси WMI.
    hres = CoSetProxyBlanket(
        pSvc,
        RPC_C_AUTHN_WINNT,
        RPC_C_AUTHZ_NONE,
        NULL,
        RPC_C_AUTHN_LEVEL_CALL,
        RPC_C_IMP_LEVEL_IMPERSONATE,
        NULL,
        EOAC_NONE);

    if (FAILED(hres))
    {
        std::cout << "Ошибка при установке уровня безопасности. Error code = 0x" << std::hex << hres << std::endl;
        pSvc->Release();
        pLoc->Release();
        CoUninitialize();
        return;
    }
}

void getGpuInfo() {
    HRESULT hres;
    IWbemLocator* pLoc = NULL;
    IWbemServices* pSvc = NULL;

    initializeCOM(hres, pLoc, pSvc);

    // Используем WMI для получения информации о видеокарте.
    IEnumWbemClassObject* pEnumerator = NULL;
    hres = pSvc->ExecQuery(
        bstr_t("WQL"),
        bstr_t("SELECT * FROM Win32_VideoController"),
        WBEM_FLAG_FORWARD_ONLY | WBEM_FLAG_RETURN_IMMEDIATELY,
        NULL,
        &pEnumerator);

    if (FAILED(hres))
    {
        std::cout << "Ошибка при выполнении запроса. Error code = 0x" << std::hex << hres << std::endl;
        pSvc->Release();
        pLoc->Release();
        CoUninitialize();
        return;
    }

    // Получение данных.
    IWbemClassObject* pclsObj = NULL;
    ULONG uReturn = 0;
    while (pEnumerator)
    {
        HRESULT hr = pEnumerator->Next(WBEM_INFINITE, 1, &pclsObj, &uReturn);
        if (0 == uReturn)
        {
            break;
        }

        VARIANT vtProp;

        // Получение имени видеокарты.
        hr = pclsObj->Get(L"Name", 0, &vtProp, 0, 0);
        std::wcout << "Видеокарта: " << vtProp.bstrVal << std::endl;
        VariantClear(&vtProp);

        pclsObj->Release();
    }

    // Очистка.
    pSvc->Release();
    pLoc->Release();
    pEnumerator->Release();
    CoUninitialize();

}

void getDiskInfo() {
    // Инфа о накопителе
    HRESULT hres;
    IWbemLocator* pLoc = NULL;
    IWbemServices* pSvc = NULL;

    initializeCOM(hres, pLoc, pSvc);

    IEnumWbemClassObject* pEnumerator = NULL;
    hres = pSvc->ExecQuery(
        bstr_t("WQL"),
        bstr_t("SELECT * FROM Win32_DiskDrive"),
        WBEM_FLAG_FORWARD_ONLY | WBEM_FLAG_RETURN_IMMEDIATELY,
        NULL,
        &pEnumerator);

    if (FAILED(hres))
    {
        std::cout << "Ошибка при выполнении запроса. Error code = 0x" << std::hex << hres << std::endl;
        pSvc->Release();
        pLoc->Release();
        CoUninitialize();
        return;
    }

    // Получение данных.
    while (pEnumerator)
    {
        HRESULT hr;
        IWbemClassObject* pclsObj = NULL;
        ULONG uReturn = 0;

        hr = pEnumerator->Next(WBEM_INFINITE, 1, &pclsObj, &uReturn);

        if (0 == uReturn)
        {
            break;
        }

        VARIANT vtProp;

        // Получение имени накопителя.
        hr = pclsObj->Get(L"Model", 0, &vtProp, 0, 0);
        std::wcout << "Накопитель: " << vtProp.bstrVal << std::endl;
        VariantClear(&vtProp);

        pclsObj->Release();
    }

    // Очистка.
    pSvc->Release();
    pLoc->Release();
    pEnumerator->Release();
    CoUninitialize();

}

void getMotherboardInfo() {
    // Материнская плата
    HRESULT hres;
    IWbemLocator* pLoc = NULL;
    IWbemServices* pSvc = NULL;

    initializeCOM(hres, pLoc, pSvc);

    IEnumWbemClassObject* pEnumerator = NULL;
    hres = pSvc->ExecQuery(
        bstr_t("WQL"),
        bstr_t("SELECT * FROM Win32_BaseBoard"),
        WBEM_FLAG_FORWARD_ONLY | WBEM_FLAG_RETURN_IMMEDIATELY,
        NULL,
        &pEnumerator);

    if (FAILED(hres))
    {
        std::cout << "Ошибка при выполнении запроса. Error code = 0x" << std::hex << hres << std::endl;
        pSvc->Release();
        pLoc->Release();
        CoUninitialize();
        return; // Исправил return на void
    }

    // Получение данных.
    while (pEnumerator)
    {
        IWbemClassObject* pclsObj = NULL;
        ULONG uReturn = 0;
        HRESULT hr = pEnumerator->Next(WBEM_INFINITE, 1, &pclsObj, &uReturn);

        if (0 == uReturn)
        {
            break;
        }

        VARIANT vtProp;

        // Получение имени материнской платы.
        hr = pclsObj->Get(L"Product", 0, &vtProp, 0, 0);
        std::wcout << "Материнская плата: " << vtProp.bstrVal << std::endl;
        VariantClear(&vtProp);

        pclsObj->Release();
    }

    // Очистка.
    pSvc->Release();
    pLoc->Release();
    pEnumerator->Release();
    CoUninitialize();


}


void getProcessorInfo() {
    // Процессор
    HRESULT hres;
    IWbemLocator* pLoc = NULL;
    IWbemServices* pSvc = NULL;

    initializeCOM(hres, pLoc, pSvc);

    IEnumWbemClassObject* pEnumerator = NULL;
    hres = pSvc->ExecQuery(
        bstr_t("WQL"),
        bstr_t("SELECT * FROM Win32_Processor"),
        WBEM_FLAG_FORWARD_ONLY | WBEM_FLAG_RETURN_IMMEDIATELY,
        NULL,
        &pEnumerator);

    if (FAILED(hres))
    {
        std::cout << "Ошибка при выполнении запроса. Error code = 0x" << std::hex << hres << std::endl;
        pSvc->Release();
        pLoc->Release();
        CoUninitialize();
        return; // Исправил return на void
    }

    // Получение данных.
    while (pEnumerator)
    {
        IWbemClassObject* pclsObj = NULL;
        ULONG uReturn = 0;
        HRESULT hr = pEnumerator->Next(WBEM_INFINITE, 1, &pclsObj, &uReturn);

        if (0 == uReturn)
        {
            break;
        }

        VARIANT vtProp;

        // Получение имени процессора.
        hr = pclsObj->Get(L"Name", 0, &vtProp, 0, 0);
        std::wcout << "Процессор: " << vtProp.bstrVal << std::endl;
        VariantClear(&vtProp);

        pclsObj->Release();
    }

    // Очистка.
    pSvc->Release();
    pLoc->Release();
    pEnumerator->Release();
    CoUninitialize();

}
