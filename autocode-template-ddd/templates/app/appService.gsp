<%
    def tableDefine=tableModel.tableDefine;
    def domainPackageName = """${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${StringUtils.lowerCase(tableDefine.id)}"""
    def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id)

%>package ${config.basePackage}.app;


import ${domainPackageName}.entity.${tableDefine.id};

/**
 * ${tableDefine.cnname}应用服务
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
public interface ${tableDefine.id}AppService {

    /**
     * 创建
     *
     * @param ${varDomainName}
     * @return
     */
    ${tableDefine.id} create(${tableDefine.id} ${varDomainName});

    /**
     * 修改
     *
     * @param ${varDomainName}
     */
    void update(${tableDefine.id} ${varDomainName});


}
