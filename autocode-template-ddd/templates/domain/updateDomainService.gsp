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
 * 修改${tableDefine.cnname}领域服务
 *
 * @author ${config.author}
* @date ${config.nowDate}
*/
@Service
public class Update${tableDefine.id}DomainService implements DomainService {

    @Resource
    private ${tableDefine.id}Validator ${varDomainName}Validator;
    @Resource
    private ${tableDefine.id}Repo ${varDomainName}Repo;


    public void update(${tableDefine.id} ${varDomainName}) {
          //查询参数验证
        ${varDomainName}.validateForLoad();
        ${tableDefine.id} ${varDomainName}FromRepo = ${varDomainName}Repo.load(${varDomainName}.get${tableDefine.id}Identifier(), ${varDomainName}.getCompanyBizIdentifier(), null);
        Validate.assertTrue(${varDomainName}FromRepo != null, "通过主键查询${tableDefine.cnname}不存在",
                UserReturnCodeEnum.C_3000_DATA_NOT_EXIST, CodeDetailEnum.CONTACT);
        ${varDomainName}FromRepo.update(${varDomainName});
        //验证服务，因为使用JSR303，也可以内置到实体中
        ${varDomainName}Validator.validateUpdate(${varDomainName}FromRepo);
        //仓库存储
        ${varDomainName}Repo.update(${varDomainName}FromRepo);
    }

}
