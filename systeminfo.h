#ifndef SYSTEMINFO_H
#define SYSTEMINFO_H

#include <QObject>
#include <QVariant>
#include <comdef.h>
#include <Wbemidl.h>

interface IWbemLocator;
interface IWbemServices;

/**
 * Class systeminfo
 *
 * @package Device-Assistant
 */
class systeminfo : public QObject
{
    Q_OBJECT
public:
    explicit systeminfo(QObject *parent = nullptr);
    Q_INVOKABLE QVariantList getGpuInfo();
    Q_INVOKABLE QString getDiskInfo();
    Q_INVOKABLE QString getMotherboardInfo();
    Q_INVOKABLE QString getProcessorInfo();
    Q_INVOKABLE QString getOSInfo();
    Q_INVOKABLE QString getRAMInfo();
    Q_INVOKABLE QString getPcName();
    Q_INVOKABLE QString getDisplayRefreshRate();

private:
    void initializeCOM(HRESULT& hres, IWbemLocator*& pLoc, IWbemServices*& pSvc);
};

#endif // SYSTEMINFO_H
