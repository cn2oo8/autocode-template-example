<%
    def tableDefine=tableModel.tableDefine;
    def domainPackageName = """${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${StringUtils.lowerCase(tableDefine.id)}"""
    def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id)
%>

package ${config.basePackage}.app.impl;

import ${config.basePackage}.app.${tableDefine.id}AppService;
import ${domainPackageName}.entity.${tableDefine.id};
import ${domainPackageName}.service.Create${tableDefine.id}DomainService;
import ${domainPackageName}.service.Update${tableDefine.id}DomainService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * ${tableDefine.cnname}应用服务实现
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@Service
public class ${tableDefine.id}AppServiceImpl implements ${tableDefine.id}AppService {

    @Resource
    private Create${tableDefine.id}DomainService create${tableDefine.id}DomainService;
    @Resource
    private Update${tableDefine.id}DomainService update${tableDefine.id}DomainService;

    @Override
    public ${tableDefine.id} create(${tableDefine.id} ${varDomainName}) {
        return create${tableDefine.id}DomainService.create(${varDomainName});
    }

    @Override
    public void update(${tableDefine.id} ${varDomainName}) {
        update${tableDefine.id}DomainService.update(${varDomainName});
    }
}
