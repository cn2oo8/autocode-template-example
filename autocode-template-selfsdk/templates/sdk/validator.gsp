${snippetTemplateUtil.getTemplate('copyrightInfo')}
<%
    def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id)
    def tableDefine=tableModel.tableDefine;
    def columns=tableDefine.columns;
%>package ${config.basePackage}.validate.provide;

import static ${config.basePackage}.common.valid.Validate.*;
import ${config.basePackage}.validate.AbstractValidator;
import org.springframework.stereotype.Service;
import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id};


/**
 * ${tableDefine.cnname} SDK 验证 类
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@Service("${varDomainName}Validator")
public class ${tableDefine.id}Validator extends AbstractValidator<${tableDefine.id}> {

}
