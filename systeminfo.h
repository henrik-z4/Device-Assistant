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
    Q_INVOKABLE void getDiskInfo();
    Q_INVOKABLE void getMotherboardInfo();
    Q_INVOKABLE void getProcessorInfo();

private:
    void initializeCOM(HRESULT& hres, IWbemLocator*& pLoc, IWbemServices*& pSvc);
};

#endif // SYSTEMINFO_H
