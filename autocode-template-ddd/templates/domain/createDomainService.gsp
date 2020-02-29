<%
    def tableDefine=tableModel.tableDefine;
    def domainPackageName = """${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${StringUtils.lowerCase(tableDefine.id)}"""
    def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id)

%>package ${domainPackageName}.service;

import com.jd.b2b.gene.domain.DomainService;
import ${domainPackageName}.entity.${tableDefine.id};
import ${domainPackageName}.repo.${tableDefine.id}Repo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 创建${tableDefine.cnname}领域服务
 *
 * @author ${config.author}
* @date ${config.nowDate}
*/
@Service
public class Create${tableDefine.id}DomainService implements DomainService {

    @Resource
    private ${tableDefine.id}Validator ${varDomainName}Validator;
    @Resource
    private ${tableDefine.id}Repo ${varDomainName}Repo;


    public ${tableDefine.id} create(${tableDefine.id} ${varDomainName}) {
        //验证服务，因为使用JSR303，也可以内置到实体中
        ${varDomainName}Validator.validateAdd(${varDomainName});
        //仓库存储
        return ${varDomainName}Repo.create(${varDomainName});
    }

}
