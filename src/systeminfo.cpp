#define _WIN32_DCOM
#include <iostream>
#include <comdef.h>
#include <Wbemidl.h>
#include "systeminfo.h"

#include <QDebug>

#pragma comment(lib, "wbemuuid.lib")

SystemInfo::SystemInfo(QObject *parent) : QObject(parent) {
    HRESULT hres;
    IWbemLocator* pLoc = nullptr;
    IWbemServices* pSvc = nullptr;
    initializeCOM(hres, pLoc, pSvc);
}

//Функиция для конвертации char* в BSTR, т. к. конченый MinGW не поддерживает _com_util::ConvertStringToBSTR. Я эту трубу шатал, весь COM поддерживает, а конкретно эту операцию - нет.
BSTR ConvertStringToBSTR(const char *pSrc)
{
    const size_t cSize = strlen(pSrc)+1;
    wchar_t* wc = new wchar_t[cSize];
    mbstowcs (wc, pSrc, cSize);

    BSTR bstr = SysAllocString(wc);
    delete [] wc;
    return bstr;
}

void SystemInfo::initializeCOM(HRESULT& hres, IWbemLocator*& pLoc, IWbemServices*& pSvc) {
    // Инициализация COM.
    hres = CoInitializeEx(nullptr, COINIT_MULTITHREADED);
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
        ConvertStringToBSTR(reinterpret_cast<const char *>(L"ROOT\\CIMV2")),
        nullptr,
        nullptr,
        0,
        0,
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

Q_INVOKABLE void SystemInfo::getGpuInfo() { 
    HRESULT hres;
    IWbemLocator* pLoc = NULL;
    IWbemServices* pSvc = NULL;

    initializeCOM(hres, pLoc, pSvc);

    // Используем WMI для получения информации о видеокарте.
    IEnumWbemClassObject* pEnumerator = NULL;
    hres = pSvc->ExecQuery(
        ConvertStringToBSTR("WQL"),
        ConvertStringToBSTR("SELECT * FROM Win32_VideoController"),
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
        qDebug() << "Видеокарта: " << QString::fromWCharArray(vtProp.bstrVal);

        VariantClear(&vtProp);

        pclsObj->Release();
    }

    // Очистка.
    pSvc->Release();
    pLoc->Release();
    pEnumerator->Release();
    CoUninitialize();

}

Q_INVOKABLE void SystemInfo::getDiskInfo() {
    // Инфа о накопителе
    HRESULT hres;
    IWbemLocator* pLoc = NULL;
    IWbemServices* pSvc = NULL;

    initializeCOM(hres, pLoc, pSvc);

    IEnumWbemClassObject* pEnumerator = NULL;
    hres = pSvc->ExecQuery(
        ConvertStringToBSTR("WQL"),
        ConvertStringToBSTR("SELECT * FROM Win32_DiskDrive"),
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
        qDebug() << "Накопитель: " << QString::fromWCharArray(vtProp.bstrVal);
        VariantClear(&vtProp);

        pclsObj->Release();
    }

    // Очистка.
    pSvc->Release();
    pLoc->Release();
    pEnumerator->Release();
    CoUninitialize();

}

Q_INVOKABLE void SystemInfo::getMotherboardInfo() {
    // Материнская плата
    HRESULT hres;
    IWbemLocator* pLoc = NULL;
    IWbemServices* pSvc = NULL;

    initializeCOM(hres, pLoc, pSvc);

    IEnumWbemClassObject* pEnumerator = NULL;
    hres = pSvc->ExecQuery(
        ConvertStringToBSTR("WQL"),
        ConvertStringToBSTR("SELECT * FROM Win32_BaseBoard"),
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
        qDebug() << "Материнская плата: " << QString::fromWCharArray(vtProp.bstrVal);
        VariantClear(&vtProp);

        pclsObj->Release();
    }

    // Очистка.
    pSvc->Release();
    pLoc->Release();
    pEnumerator->Release();
    CoUninitialize();


}


Q_INVOKABLE void SystemInfo::getProcessorInfo() {
    // Процессор
    HRESULT hres;
    IWbemLocator* pLoc = NULL;
    IWbemServices* pSvc = NULL;

    initializeCOM(hres, pLoc, pSvc);

    IEnumWbemClassObject* pEnumerator = NULL;
    hres = pSvc->ExecQuery(
        ConvertStringToBSTR("WQL"),
        ConvertStringToBSTR("SELECT * FROM Win32_Processor"),
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
        qDebug() << "Процессор: " << QString::fromWCharArray(vtProp.bstrVal);
        VariantClear(&vtProp);

        pclsObj->Release();
    }

    // Очистка.
    pSvc->Release();
    pLoc->Release();
    pEnumerator->Release();
    CoUninitialize();

}
