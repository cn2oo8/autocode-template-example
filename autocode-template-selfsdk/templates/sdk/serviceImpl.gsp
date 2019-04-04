${snippetTemplateUtil.getTemplate('copyrightInfo')}
<%
    def varDomainName = tableNameUtil.lowerCaseFirst(tableDefine.id);
    def managerName = varDomainName + "Manager";
    def pkColumn = tableDefine.getPkColumn();
    def pkJavaType = tableNameUtil.getDataType(pkColumn?.columnType);
%>package ${config.basePackage}.service${PubUtils.addStrAfterSeparator(config.category, ".")}.impl;

import javax.annotation.Resource;
import ${config.basePackage}.builder.impl.${tableDefine.id}Builder;
import ${config.basePackage}.manager${PubUtils.addStrAfterSeparator(config.category, ".")}.${tableDefine.id}Manager;
import ${config.basePackage}.service${PubUtils.addStrAfterSeparator(config.category, ".")}.${tableDefine.id}Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category, ".")}.${tableDefine.id};
import ${config.basePackage}.validate.provide.${tableDefine.id}Validator;
import ${config.basePackage}.service.AbstractService;
import org.springframework.stereotype.Service;

/**
 * ${tableDefine.cnname} service实现
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@Service("${varDomainName}Service")
public class ${tableDefine.id}ServiceImpl extends
    AbstractService<${tableDefine.id}> implements ${tableDefine.id}Service {

    protected static final Logger LOGGER = LoggerFactory.getLogger(${tableDefine.id}ServiceImpl.class);

    @Resource(name="${varDomainName}Validator")
    private ${tableDefine.id}Validator ${varDomainName}Validator;

    @Resource(name="${managerName}")
    private ${tableDefine.id}Manager ${managerName};

    @Resource(name="${varDomainName}Builder")
    private ${tableDefine.id}Builder ${varDomainName}Builder;


    /******* getter and setter ***/
    public ${tableDefine.id}Manager getManager() {
        return ${varDomainName}Manager;
    }

    public ${tableDefine.id}Validator getValidator() {
        return ${varDomainName}Validator;
    }

    @Override
    public ${tableDefine.id}Builder getBuilder() {
        return ${varDomainName}Builder;
    }

}
