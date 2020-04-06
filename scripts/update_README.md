# Continuous Update Delivery for WSO2 API Manager

### Prequisites
* Product packs should be included in the `/modules/apim_common/files/packs` directory

---
**NOTE**

Provided WUM updated packs should contain the latest updates for wso2am-3.1.0 and wso2am-analytics-3.1.0

---

### Usage
While executing the update script, provide the profile name. The pack corresponding to the profile will begin updating.
```bash
./update.sh -p <profile-name>
```
Any of the following profile names can be provided as arguments:
* apim
* apim_gateway
* apim_km
* apim_publisher
* apim_devportal
* apim_tm
* apim_analytics_dashboard
* apim_analytics_worker

If any file that is used as a template is updated, a warning will be displayed. Update the relevant template files accordingly before pushing updates to the nodes.
