<%
    def columns = tableDefine.columns
    def varDomainName = tableNameUtil.lowerCaseFirst(tableDefine.id)
    def urlPrefix = "/" + PubUtils.addStrBeforeSeparator(PubUtils.packageToPath(config.category), "/") + varDomainName

%>
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
    dicts:${customTool['tableModelDictDefineJson'](tableModel,'\t\t\t')}
}