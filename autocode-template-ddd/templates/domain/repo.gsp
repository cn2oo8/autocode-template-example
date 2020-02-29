<%
    def tableDefine=tableModel.tableDefine;
    def domainPackageName = """${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${StringUtils.lowerCase(tableDefine.id)}"""
    def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id)

%>package ${domainPackageName}.repo;

import ${domainPackageName}.entity.${tableDefine.id};
import ${domainPackageName}.entity.${tableDefine.id}Identifier;
import com.jd.b2b.user.sdk.domain.UserBaseQuery;

/**
 * ${tableDefine.cnname}仓库
 *
 * @author david
 * @date 2020-02-27
 */
public interface ${tableDefine.id}Repo {

    /**
     * 保存${tableDefine.cnname}信息
     *
     * @param ${varDomainName}
     * @return
     */
    ${tableDefine.id} create(${tableDefine.id} ${varDomainName});

    /**
     * 更新${tableDefine.cnname}信息
     *
     * @param ${varDomainName}
     */
    void update(${tableDefine.id} ${varDomainName});


    /**
     * 按唯一标识加载${tableDefine.cnname}
     *
     * @param ${varDomainName}Identifier ${tableDefine.cnname}唯一标识
     * @param baseQuery             基础查询对象
     * @return
     */
    ${tableDefine.id} load(${tableDefine.id}Identifier ${varDomainName}Identifier, UserBaseQuery baseQuery);
}
