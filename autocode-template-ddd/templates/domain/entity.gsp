<%
	  def tableDefine=tableModel.tableDefine;
	  def columns=tableDefine.columns;
	  def pkColumn=tableDefine.getPkColumn();
	  def upperPkName=tableNameUtil.upperFirst(pkColumn.dataName)
	  def packageName = """${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${StringUtils.lowerCase(tableDefine.id)}"""
	  Set excludes = ["id","status","operator","operator","created","modified","concurrentVersion","dataVersion","router"]
	  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id)

%>package ${packageName}.entity;

import com.jd.b2b.gene.domain.AggregateRoot;
import com.jd.b2b.user.cbi.sdk.validate.DefValidateGroup;
import com.jd.b2b.user.dbi.domain.entity.BaseEntity;
import com.jd.b2b.user.sdk.enums.Platform;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;
import javax.validation.constraints.NotNull;

/**
 * ${tableDefine.cnname}实体
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@Getter
@Setter(AccessLevel.PRIVATE)
public class ${tableDefine.id} extends BaseEntity implements AggregateRoot<${tableDefine.id}Identifier> {
<%
 columns.each{
		  if(!excludes.contains(it.dataName)) {
			  println "	/**  ${it.cnname}  */";
			  println "	private ${tableNameUtil.getDataType(it.columnType)} ${it.dataName}; "
		  }
	  };
%>

    @Override
    public ${tableDefine.id}Identifier getIdentifier() {
        return ${varDomainName}Identifier;
    }

    /**
     * 更新信息
     *
     * @param updateParam
     */
    public void update(ContactInfo updateParam) {
        //需要删除不必要的更新字段
        <%
            columns.each{
				def upperFistName=tableNameUtil.upperFirst(it.dataName)
		%>
            this.set${upperFistName}(updateParam.get${upperFistName}());<%
        }
        %>
    }


    public static class ${tableDefine.id}Builder extends BaseEntityBuilder<${tableDefine.id}, ${tableDefine.id}.${tableDefine.id}Builder> {

        public ${tableDefine.id}Builder() {
            entity = new ${tableDefine.id}();
        }

        public ${tableDefine.id}.${tableDefine.id}Builder contactIdentifier(${tableDefine.id}Identifier ${varDomainName}Identifier) {
            entity.set${tableDefine.id}Identifier(${varDomainName}Identifier);
            return this;
        }


		<%
			columns.each{
					String dataName = it.dataName
					def upperFistName=tableNameUtil.upperFirst(dataName)
					def dataType =tableNameUtil.getDataType(it.columnType)
				%>
				public ${tableDefine.id}.${tableDefine.id}Builder ${dataName}(${dataType} ${dataName}) {
				entity.set${upperFistName}(${dataName});
				return this;
        		}
			 <%
			}
		%>
    }
}