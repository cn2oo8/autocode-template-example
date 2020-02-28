<%
    def tableDefine=tableModel.tableDefine;
    def columns=tableDefine.columns;
    def pkColumn=tableDefine.getPkColumn();
    def upperPkName=tableNameUtil.upperFirst(pkColumn.dataName)
    def packageName = """${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${StringUtils.lowerCase(tableDefine.id)}"""
    Set excludes = ["id","status","operator","operator","created","modified","concurrentVersion","dataVersion","router"]
    def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id)

%>package ${config.basePackage}.provider.assembler;

import com.jd.b2b.user.cbi.sdk.dto.userplat.${tableDefine.id}Dto;
import ${packageName}.entity.${tableDefine.id};

/**
 * ${tableDefine.cnname}组装器
 *
 * @author ${config.author}
* @date ${config.nowDate}
*/
public class ${tableDefine.id}Assembler {

   /**
    * 组装领域对象
    *
    * @param ${varDomainName}Dto
    * @return 领域对象
    */
   public static ${tableDefine.id} assemble(${tableDefine.id}Dto ${varDomainName}Dto) {
        ${tableDefine.id}.${tableDefine.id}Builder builder = new ${tableDefine.id}.${tableDefine.id}Builder();
        <%
            columns.each{
                def upperFistName=tableNameUtil.upperFirst(it.dataName)
                println "	builder.${it.dataName}(${varDomainName}Dto.get${upperFistName}()); "
            }
        %>
       return builder.build();
   }

    /**
    * 组装SDK对象
    *
    * @param ${varDomainName}
    * @return sdk对象
    */
   public static ${tableDefine.id}Dto assemble(${tableDefine.id} ${varDomainName}) {
       ${tableDefine.id}Dto ${varDomainName}Dto = new ${tableDefine.id}Dto();
        <%
            columns.each{
                def upperFistName=tableNameUtil.upperFirst(it.dataName)
                println "	${varDomainName}Dto.set${upperFistName}(${varDomainName}.get${upperFistName}()); "
            }
        %>
       return ${varDomainName}Dto;
   }
}
