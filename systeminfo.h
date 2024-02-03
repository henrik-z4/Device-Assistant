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
    Q_INVOKABLE Q_PROPERTY(QVariantList gpuInfo READ getGpuInfo CONSTANT)
    Q_INVOKABLE Q_PROPERTY(QString diskInfo READ getDiskInfo CONSTANT)
    Q_INVOKABLE Q_PROPERTY(QString motherboardInfo READ getMotherboardInfo CONSTANT)
    Q_INVOKABLE Q_PROPERTY(QString processorInfo READ getProcessorInfo CONSTANT)
    Q_INVOKABLE Q_PROPERTY(QString osInfo READ getOSInfo CONSTANT)
    Q_INVOKABLE Q_PROPERTY(QString ramInfo READ getRAMInfo CONSTANT)
    Q_INVOKABLE Q_PROPERTY(QString pcName READ getPcName CONSTANT)
    Q_INVOKABLE Q_PROPERTY(QString displayRefreshRate READ getDisplayRefreshRate CONSTANT)
    
public:
    explicit systeminfo(QObject *parent = nullptr);

    Q_INVOKABLE QVariantList getGpuInfo() const;
    Q_INVOKABLE QString getDiskInfo() const;
    Q_INVOKABLE QString getMotherboardInfo() const;
    Q_INVOKABLE QString getProcessorInfo() const;
    Q_INVOKABLE QString getOSInfo() const;
    Q_INVOKABLE QString getRAMInfo() const;
    Q_INVOKABLE QString getPcName() const;
    Q_INVOKABLE QString getDisplayRefreshRate() const;

private:
    void initializeCOM(HRESULT& hres, IWbemLocator*& pLoc, IWbemServices*& pSvc);

    Q_INVOKABLE QVariantList retrieveGpuInfo();
    Q_INVOKABLE QVariantList m_gpuInfo;

    Q_INVOKABLE QString retrieveDiskInfo();
    Q_INVOKABLE QString m_diskInfo;

    Q_INVOKABLE QString retrieveMotherboardInfo();
    Q_INVOKABLE QString m_motherboardInfo;

    Q_INVOKABLE QString retrieveProcessorInfo();
    Q_INVOKABLE QString m_processorInfo;

    Q_INVOKABLE QString retrieveOSInfo();
    Q_INVOKABLE QString m_osInfo;

    Q_INVOKABLE QString retrieveRAMInfo();
    Q_INVOKABLE QString m_ramInfo;

    Q_INVOKABLE QString retrievePcName();
    Q_INVOKABLE QString m_pcName;

    Q_INVOKABLE QString retrieveDisplayRefreshRate();
    Q_INVOKABLE QString m_displayRefreshRate;
};

#endif // SYSTEMINFO_H