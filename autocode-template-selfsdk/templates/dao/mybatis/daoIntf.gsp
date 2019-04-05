<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def pkColumn=tableDefine.getPkColumn();
  def pkJavaType=tableNameUtil.getDataType(pkColumn?.columnType);
%>package ${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,"." )};

import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${tableDefine.id};
import ${config.basePackage}.dao.BaseDao;

/**
 * ${tableDefine.cnname} Dao接口类
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
public interface ${tableDefine.id}Dao extends BaseDao<${tableDefine.id}> {

}
