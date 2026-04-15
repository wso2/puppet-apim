# Continuous Update Delivery for WSO2 API Manager

### Prerequisites
* Product packs should be included in the `/modules/apim_common/files/packs` directory
* For APIM 4.5.0 and later, use the separate component packs:
  - `wso2am-<version>.zip` - All-in-one pack (default profile)
  - `wso2am-universal-gw-<version>.zip` - Gateway component
  - `wso2am-acp-<version>.zip` - Access Control Plane component (also used for Key Manager)
  - `wso2am-tm-<version>.zip` - Traffic Manager component

---
**NOTE**

Provided U2 updated packs should contain the latest updates for wso2am-4.7.0

For APIM 4.6.0 and later, the update tool (`wso2update_linux`) is not bundled in the pack. The script will automatically run `update_tool_setup.sh` to download the appropriate update tool for your architecture.

---

### Usage
While executing the update script, provide the profile name. The pack corresponding to the profile will begin updating.
```bash
./update.sh -p <profile-name>
```
Any of the following profile names can be provided as arguments:
* apim - All-in-one pack (wso2am-<version>.zip)
* apim_gateway - Gateway component (wso2am-universal-gw-<version>.zip)
* apim_control_plane - Access Control Plane component (wso2am-acp-<version>.zip)
* apim_tm - Traffic Manager component (wso2am-tm-<version>.zip)
* apim_km - Key Manager profile (uses wso2am-acp-<version>.zip, same as control plane)

**Note:** The Key Manager (`apim_km`) and Access Control Plane (`apim_control_plane`) profiles share the same ACP pack. Updates to the ACP pack apply to both.

If any file that is used as a template is updated, a warning will be displayed. Update the relevant template files accordingly before pushing updates to the nodes.
