#ifndef SYSTEMINFO_H
#define SYSTEMINFO_H

#include <QObject>
#include <comdef.h>
#include <Wbemidl.h>

interface IWbemLocator;
interface IWbemServices;
class SystemInfo : public QObject
{
    Q_OBJECT
public:
    explicit SystemInfo(QObject *parent = nullptr);
    Q_INVOKABLE void getGpuInfo();
    Q_INVOKABLE void getDiskInfo();
    Q_INVOKABLE void getMotherboardInfo();
    Q_INVOKABLE void getProcessorInfo();

private:
    void initializeCOM(HRESULT& hres, IWbemLocator*& pLoc, IWbemServices*& pSvc);
};

#endif // SYSTEMINFO_H
