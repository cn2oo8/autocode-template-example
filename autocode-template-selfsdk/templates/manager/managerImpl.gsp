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

    /**
    * 访问层
    */
    @Resource
    private ${tableDefine.id}Dao ${varDomainName}Dao;
    /**
    * bean构建服务
    */
    @Resource(name="${varDomainName}Builder")
    ${tableDefine.id}Builder ${varDomainName}Builder;


    /******* getter and setter ***/
     @Override
     public ${tableDefine.id}Builder getBuilder() {
        return ${varDomainName}Builder;
    }

    @Override
    public ${tableDefine.id}Dao getDao() {
        return ${varDomainName}Dao;
    }
}
