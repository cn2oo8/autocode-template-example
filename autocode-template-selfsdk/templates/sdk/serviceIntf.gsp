${snippetTemplateUtil.getTemplate('copyrightInfo')}
<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def pkColumn=tableDefine.getPkColumn();
  def pkJavaType=tableNameUtil.getDataType(pkColumn?.columnType);
%>package ${config.basePackage}.service${PubUtils.addStrAfterSeparator(config.category,".")};

import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${tableDefine.id};
import ${config.basePackage}.service.BaseService;

/**
 *  ${tableDefine.cnname} service 接口
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 *
 */
public interface ${tableDefine.id}Service extends BaseService<${tableDefine.id}>{

}
