${snippetTemplateUtil.getTemplate('copyrightInfo')}
<%
    def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id)
    def tableDefine=tableModel.tableDefine
    def columns=tableDefine.columns
%>package ${config.basePackage}.builder.impl;

import ${config.basePackage}.builder.AbstractBuilder;
import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${tableDefine.id};
import org.springframework.stereotype.Service;

/**
 * ${tableDefine.cnname} Builder 类
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@Service("${varDomainName}Builder")
public class ${tableDefine.id}Builder extends AbstractBuilder<${tableDefine.id}>{

    @Override
    public String getBizName() {
        return "${tableDefine.cnname}";
    }
     @Override
    public Class getBizClass() {
        return ${tableDefine.id}.class;
    }
}