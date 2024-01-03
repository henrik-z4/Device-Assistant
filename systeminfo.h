#ifndef SYSTEMINFO_H
#define SYSTEMINFO_H

#include <QObject>
#include <comdef.h>
#include <Wbemidl.h>

interface IWbemLocator;
interface IWbemServices;

class systeminfo : public QObject
{
    Q_OBJECT
public:
    explicit systeminfo(QObject *parent = nullptr);
    Q_INVOKABLE QString getGpuInfo();
    Q_INVOKABLE QString getDiskInfo();
    Q_INVOKABLE QString getMotherboardInfo();
    Q_INVOKABLE QString getProcessorInfo();
    Q_INVOKABLE QString getOSInfo();
    Q_INVOKABLE QString getRAMInfo();

private:
    void initializeCOM(HRESULT& hres, IWbemLocator*& pLoc, IWbemServices*& pSvc);
};

#endif // SYSTEMINFO_H
