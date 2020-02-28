<%
    def tableDefine=tableModel.tableDefine;
    def pkColumn=tableDefine.getPkColumn();
    def pKDataType =tableNameUtil.getDataType(pkColumn.columnType)


    def packageName = """${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${StringUtils.lowerCase(tableDefine.id)}"""
    def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id)

%>package ${packageName}.entity;

import com.jd.b2b.gene.domain.ValueObject;

/**
 * ${tableDefine.cnname}主键
 *
 * @author ${config.author}
* @date ${config.nowDate}
*/
public class ${tableDefine.id}Identifier implements ValueObject {

   /**
    * ${tableDefine.cnname}唯一主键
    */
   private ${pKDataType} ${pkColumn.dataName};

    public ${tableDefine.id}Identifier(${pKDataType} ${pkColumn.dataName}) {
        this.${pkColumn.dataName} = ${pkColumn.dataName};
    }

    public static ${tableDefine.id}Identifier of(${pKDataType} ${pkColumn.dataName}) {
        Validate.notNull(${pkColumn.dataName}, CodeDetailEnum.CONTACT_ID);
        return new ${tableDefine.id}Identifier(${pkColumn.dataName});
    }
}
