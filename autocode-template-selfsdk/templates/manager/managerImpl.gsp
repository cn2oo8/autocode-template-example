<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def pkColumn=tableDefine.getPkColumn();
  def pkJavaType=tableNameUtil.getDataType(pkColumn?.columnType);
%>package ${config.basePackage}.manager${PubUtils.addStrAfterSeparator(config.category,"." )}.impl;

import org.springframework.stereotype.Component;
import javax.annotation.Resource;
import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id};
import ${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}Dao;
import ${config.basePackage}.manager${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}Manager;
import ${config.basePackage}.manager.AbstractManager;
import ${config.basePackage}.builder.impl.${tableDefine.id}Builder;
/**
 * ${tableDefine.cnname}Manager实现类
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@Component("${varDomainName}Manager")
public class ${tableDefine.id}ManagerImpl extends AbstractManager<${tableDefine.id}> implements ${tableDefine.id}Manager {

    @Resource
    private ${tableDefine.id}Dao ${varDomainName}Dao;
    @Resource(name="${varDomainName}Builder")
    ${tableDefine.id}Builder ${varDomainName}Builder;


    /******* getter and setter ***/
    public ${tableDefine.id}Builder getBuilder() {
        return ${varDomainName}Builder;
    }
    public ${tableDefine.id}Dao getDao() {
        return ${varDomainName}Dao;
    }
}
