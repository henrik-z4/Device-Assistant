#define _WIN32_DCOM

#include <iostream>
#include <comdef.h>
#include <Wbemidl.h>
#include "systeminfo.h"
#include <windows.h>

#include <QDebug>
#include <QString>

#pragma comment(lib, "wbemuuid.lib")

systeminfo::systeminfo(QObject *parent) : QObject(parent) {
    HRESULT hres;
    IWbemLocator* pLoc = nullptr;
    IWbemServices* pSvc = nullptr;
    initializeCOM(hres, pLoc, pSvc);
}



/**
 * Конвертация char* в BSTR, т. к. конченый MinGW не поддерживает _com_util::ConvertStringToBSTR. Я эту трубу шатал, весь COM поддерживает, а конкретно эту операцию - нет.
 *
 * @param const char *pSrc
 *
 * @return BSTR
 */
BSTR ConvertStringToBSTR(const char *pSrc)
{
    const size_t cSize = strlen(pSrc)+1;
    wchar_t* wc = new wchar_t[cSize];
    mbstowcs (wc, pSrc, cSize);

    BSTR bstr = SysAllocString(wc);
    delete [] wc;
    return bstr;
}



/**
 * Инициализация COM
 *
 * @param HRESULT& hres
 * @param IWbemLocator*& pLoc
 * @param IWbemServices*& pSvc
 */
void systeminfo::initializeCOM(HRESULT& hres, IWbemLocator*& pLoc, IWbemServices*& pSvc)
{
    /** @var hres */
    hres = CoInitializeEx(nullptr, COINIT_MULTITHREADED);

    if (FAILED(hres) && hres != RPC_E_CHANGED_MODE) {
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

    if(hres == RPC_E_TOO_LATE)
        hres = S_OK;
    else if (FAILED(hres))
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

    if (FAILED(hres)) {
        std::cout << "Ошибка при создании экземпляра IWbemLocator. Error code = 0x" << std::hex << hres << std::endl;
        CoUninitialize();
        return;
    }

    // Подключение к пространству имен WMI.
    hres = pLoc->ConnectServer(
        ConvertStringToBSTR("ROOT\\CIMV2"),
        nullptr,
        nullptr,
        0,
        0,
        0,
        0,
        &pSvc);

    if (FAILED(hres)) {
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

    if (FAILED(hres)) {
        std::cout << "Ошибка при установке уровня безопасности. Error code = 0x" << std::hex << hres << std::endl;
        pSvc->Release();
        pLoc->Release();
        CoUninitialize();
        return;
    }
}



/**
 * Получение информации о видеокарте
 *
 * @return @QString
 */
Q_INVOKABLE QString systeminfo::getGpuInfo()
{
    HRESULT hres;
    IWbemLocator* pLoc = NULL;
    IWbemServices* pSvc = NULL;
    initializeCOM(hres, pLoc, pSvc);

    // Использование WMI для получения информации о видеокарте
    IEnumWbemClassObject* pEnumerator = NULL;

    hres = pSvc->ExecQuery(
        ConvertStringToBSTR("WQL"),
        ConvertStringToBSTR("SELECT * FROM Win32_VideoController"),
        WBEM_FLAG_FORWARD_ONLY | WBEM_FLAG_RETURN_IMMEDIATELY,
        NULL,
        &pEnumerator);

    if (FAILED(hres)) {
        std::cout << "Query execution failed. Error code = 0x" << std::hex << hres << std::endl;
        pSvc->Release();
        pLoc->Release();
        CoUninitialize();
        return QString(); // В случае ошибки возвращает пустую строку
    }

    IWbemClassObject* pclsObj = NULL;
    ULONG uReturn = 0;
    QString gpuInfo;

    while (pEnumerator) {
        HRESULT hr = pEnumerator->Next(WBEM_INFINITE, 1, &pclsObj, &uReturn);

        if (0 == uReturn)
        {
            break;
        }

        VARIANT vtProp;

        // Получения названия видеокарты
        hr = pclsObj->Get(L"Name", 0, &vtProp, 0, 0);
        gpuInfo = QString::fromWCharArray(vtProp.bstrVal);
        qDebug() << "GPU: " << gpuInfo;
        VariantClear(&vtProp);
        pclsObj->Release();
    }


    // Очистка
    pSvc->Release();
    pLoc->Release();
    pEnumerator->Release();
    CoUninitialize();
    return gpuInfo;
}



/**
 * Получение информации о накопителе
 *
 * @return QString
 */
Q_INVOKABLE QString systeminfo::getDiskInfo()
{
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

    if (FAILED(hres)) {
        std::cout << "Ошибка при выполнении запроса. Error code = 0x" << std::hex << hres << std::endl;
        pSvc->Release();
        pLoc->Release();
        CoUninitialize();
        return QString(); // В случае ошибки возвращает пустую строку
    }

    // Получение данных.
    QString storageModel;
    while (pEnumerator) {
        IWbemClassObject* pclsObj = NULL;
        ULONG uReturn = 0;
        HRESULT hr = pEnumerator->Next(WBEM_INFINITE, 1, &pclsObj, &uReturn);

        if (0 == uReturn) {
            break;
        }

        VARIANT vtProp;

        // Получение названия накопителя.
        hr = pclsObj->Get(L"Model", 0, &vtProp, 0, 0);
        storageModel = QString::fromWCharArray(vtProp.bstrVal);
        qDebug() << "Storage: " << storageModel;
        VariantClear(&vtProp);

        pclsObj->Release();
    }


    // Очистка.
    pSvc->Release();
    pLoc->Release();
    pEnumerator->Release();
    CoUninitialize();
    return storageModel;
}



/**
 * Получение информации о материнской плате
 *
 * @return QString
 */
Q_INVOKABLE QString systeminfo::getMotherboardInfo()
{
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

    if (FAILED(hres)) {
        std::cout << "Ошибка при выполнении запроса. Error code = 0x" << std::hex << hres << std::endl;
        pSvc->Release();
        pLoc->Release();
        CoUninitialize();
        return QString(); // Возвращает пустую строку при ошибке
    }

    // Получение данных.
    QString motherboardInfo;
    while (pEnumerator) {
        IWbemClassObject* pclsObj = NULL;
        ULONG uReturn = 0;
        HRESULT hr = pEnumerator->Next(WBEM_INFINITE, 1, &pclsObj, &uReturn);

        if (0 == uReturn) {
            break;
        }

        VARIANT vtProp;

        // Получение имени материнской платы.
        hr = pclsObj->Get(L"Product", 0, &vtProp, 0, 0);
        motherboardInfo = QString::fromWCharArray(vtProp.bstrVal);
        qDebug() << "Motherboard: " << motherboardInfo;
        VariantClear(&vtProp);

        pclsObj->Release();
    }

    // Очистка.
    pSvc->Release();
    pLoc->Release();
    pEnumerator->Release();
    CoUninitialize();

    return motherboardInfo;
}



/**
 * Получение информации о процессоре
 *
 * @return QString
 */
Q_INVOKABLE QString systeminfo::getProcessorInfo()
{
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

    if (FAILED(hres)) {
        std::cout << "Ошибка при выполнении запроса. Error code = 0x" << std::hex << hres << std::endl;
        pSvc->Release();
        pLoc->Release();
        CoUninitialize();
        return QString(); // Возвращает пустую строку при ошибке
    }

    // Получение данных.
    QString processorInfo;
    while (pEnumerator) {
        IWbemClassObject* pclsObj = NULL;
        ULONG uReturn = 0;
        HRESULT hr = pEnumerator->Next(WBEM_INFINITE, 1, &pclsObj, &uReturn);

        if (0 == uReturn) {
            break;
        }

        VARIANT vtProp;

        // Получение имени процессора.
        hr = pclsObj->Get(L"Name", 0, &vtProp, 0, 0);
        processorInfo = QString::fromWCharArray(vtProp.bstrVal);
        qDebug() << "CPU: " << processorInfo;
        VariantClear(&vtProp);

        pclsObj->Release();
    }

    // Очистка.
    pSvc->Release();
    pLoc->Release();
    pEnumerator->Release();
    CoUninitialize();

    return processorInfo;
}



/**
 * Получение информации об операционной системе
 *
 * @return QString
 */
Q_INVOKABLE QString systeminfo::getOSInfo()
{
    // ОС
    HRESULT hres;
    IWbemLocator* pLoc = NULL;
    IWbemServices* pSvc = NULL;

    initializeCOM(hres, pLoc, pSvc);

    IEnumWbemClassObject* pEnumerator = NULL;
    hres = pSvc->ExecQuery(
        ConvertStringToBSTR("WQL"),
        ConvertStringToBSTR("SELECT * FROM Win32_OperatingSystem"),
        WBEM_FLAG_FORWARD_ONLY | WBEM_FLAG_RETURN_IMMEDIATELY,
        NULL,
        &pEnumerator);

    if (FAILED(hres)) {
        std::cout << "Ошибка при выполнении запроса. Error code = 0x" << std::hex << hres << std::endl;
        pSvc->Release();
        pLoc->Release();
        CoUninitialize();
        return QString(); // Возвращает пустую строку при ошибке
    }

    // Получение данных.
    QString osInfo;
    while (pEnumerator) {
        IWbemClassObject* pclsObj = NULL;
        ULONG uReturn = 0;
        HRESULT hr = pEnumerator->Next(WBEM_INFINITE, 1, &pclsObj, &uReturn);

        if (0 == uReturn) {
            break;
        }

        VARIANT vtProp;

        // Получение имени ОС.
        hr = pclsObj->Get(L"Caption", 0, &vtProp, 0, 0);
        osInfo = QString::fromWCharArray(vtProp.bstrVal);
        qDebug() << "OS: " << osInfo;
        VariantClear(&vtProp);

        pclsObj->Release();
    }

    // Очистка.
    pSvc->Release();
    pLoc->Release();
    pEnumerator->Release();
    CoUninitialize();

    return osInfo;
}



/**
 * Получение информации об оперативной памяти
 *
 * @return QString
 */
Q_INVOKABLE QString systeminfo::getRAMInfo()
{
    // Оперативка
    HRESULT hres;
    IWbemLocator* pLoc = NULL;
    IWbemServices* pSvc = NULL;

    initializeCOM(hres, pLoc, pSvc);

    IEnumWbemClassObject* pEnumerator = NULL;
    hres = pSvc->ExecQuery(
        ConvertStringToBSTR("WQL"),
        ConvertStringToBSTR("SELECT * FROM Win32_OperatingSystem"),
        WBEM_FLAG_FORWARD_ONLY | WBEM_FLAG_RETURN_IMMEDIATELY,
        NULL,
        &pEnumerator);

    if (FAILED(hres)) {
        std::cout << "Ошибка при выполнении запроса. Error code = 0x" << std::hex << hres << std::endl;
        pSvc->Release();
        pLoc->Release();
        CoUninitialize();
        return QString(); // Возвращает пустую строку при ошибке
    }

    // Получение данных.
    QString ramInfo;
    while (pEnumerator) {
        IWbemClassObject* pclsObj = NULL;
        ULONG uReturn = 0;
        HRESULT hr = pEnumerator->Next(WBEM_INFINITE, 1, &pclsObj, &uReturn);

        if (0 == uReturn) {
            break;
        }

        VARIANT vtProp;

        // Получение общего объема оперативной памяти.
        hr = pclsObj->Get(L"TotalVisibleMemorySize", 0, &vtProp, 0, 0);
        
        unsigned long long totalMemorySize = _wtoi64(vtProp.bstrVal);
        unsigned long long totalMemorySizeGB = totalMemorySize / (1024 * 1024);

        ramInfo = QString::number(totalMemorySizeGB) + " ГБ";
        qDebug() << "RAM: " << ramInfo;
        VariantClear(&vtProp);

        pclsObj->Release();
    }

    // Очистка.
    pSvc->Release();
    pLoc->Release();
    pEnumerator->Release();
    CoUninitialize();

    return ramInfo;
}



/**
 * Получение имени компьютера
 *
 * @return @QString
 */
Q_INVOKABLE QString systeminfo::getPcName()
{
    char buffer[256];
    DWORD size = 256;
    GetComputerNameA(buffer,&size);
    return buffer;
}



/**
 * Получение частоты обновления димплея
 *
 * @return @QString
 */
Q_INVOKABLE QString systeminfo::getDisplayRefreshRate()
{
    HDC hDCScreen = GetDC(NULL);
    int refresh  = GetDeviceCaps(hDCScreen, VREFRESH);
    ReleaseDC(NULL,  hDCScreen);
    QString refreshRate = QString::number(refresh) + " Гц";
    qDebug() << "Hertz: " << refreshRate;
    return refreshRate;
}