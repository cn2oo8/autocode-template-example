<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id)
%>

<!-- ${tableDefine.cnname} soa 服务 -->
<jsf:provider id="${varDomainName}ServiceJsf"
                  interface="${config.basePackage}.sdk.service${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}SdkService"
                  alias="\${b2b.provider.jsf.alias}" ref="${varDomainName}SdkService" server="jsf">
</jsf:provider>