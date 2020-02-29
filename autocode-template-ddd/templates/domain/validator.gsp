<%
    def tableDefine=tableModel.tableDefine;
    def domainPackageName = """${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${StringUtils.lowerCase(tableDefine.id)}"""
    def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id)

%>package ${domainPackageName}.service;

import com.jd.b2b.gene.domain.annotation.DomainService;
import com.jd.b2b.user.cbi.sdk.validate.DefValidateGroup;
import com.jd.b2b.user.dbi.common.validate.Validate;
import ${domainPackageName}.entity.${tableDefine.id};
import com.jd.b2b.user.sdk.enums.returncode.CodeDetailEnum;
import org.springframework.stereotype.Service;

/**
 * ${tableDefine.cnname}验证服务
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@Service
@DomainService
public class ${tableDefine.id}Validator {

    /**
     * ${tableDefine.cnname}验证，因为使用jsr303，故而不使用自己验证
     *
     * @param ${varDomainName}
     */
    public void validateAdd(${tableDefine.id} ${varDomainName}) {
        Validate.validateJSR303(${varDomainName}, DefValidateGroup.Add.class, CodeDetailEnum.CONTACT.getDesc());
    }


    /**
     * ${tableDefine.cnname}验证
     *
     * @param ${varDomainName}
     */
    public void validateUpdate(${tableDefine.id} ${varDomainName}) {
        Validate.validateJSR303(${varDomainName}, DefValidateGroup.Update.class, CodeDetailEnum.CONTACT.getDesc());
    }

}
