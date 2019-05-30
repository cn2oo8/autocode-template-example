<%
    def columns = tableDefine.columns
    def varDomainName = tableNameUtil.lowerCaseFirst(tableDefine.id)
    def urlPrefix = "/" + PubUtils.addStrBeforeSeparator(PubUtils.packageToPath(config.category), "/") + varDomainName

%>
/**
* 此配置文件，请将请求urls放置到常量里面，方便使用。 如： src/constants/urls.js
* dicts请放置到字典项配置常量里面，方便公用使用。 如：src/constants/dicts.js
* 相关示例，可以参考
https://github.com/cn2oo8/iview-admin/tree/d_20190525_clean_more 相关改造；需要使用到组件也可以从该分支获取。
*/
export default {
    urls: {
        '${config.category}': {
            '${varDomainName}': {
              'list': '${urlPrefix}/list',
              'add': '${urlPrefix}/add',
              'update': '${urlPrefix}/update',
              'delete': '${urlPrefix}/delete'
            }
        }
    },
    dicts:${customTool['tableModelDictDefineJson'](tableModel,'')}
}