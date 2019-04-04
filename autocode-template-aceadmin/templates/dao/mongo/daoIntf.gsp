${snippetTemplateUtil.getTemplate('copyrightInfo')}
<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def pkColumn=tableDefine.getPkColumn();
  def pkJavaType=tableNameUtil.getDataType(pkColumn?.columnType);
%>package ${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,"." )};

import java.util.List;
import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${tableDefine.id};
import java.util.Map;
import ${config.basePackage}.mongohelper.IBaseDao;

/**
 * ${tableDefine.cnname} Dao接口类
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
public interface ${tableDefine.id}Dao extends IBaseDao<${tableDefine.id}> {
}
