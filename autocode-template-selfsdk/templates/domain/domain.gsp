${snippetTemplateUtil.getTemplate('copyrightInfo')}

<%
	  def tableDefine=tableModel.tableDefine;
	  def columns=tableDefine.columns;
	  def pkColumn=tableDefine.getPkColumn();
	  def upperPkName=tableNameUtil.upperFirst(pkColumn.dataName)

	  Set excludes = ["id","status","operator","created","modified","concurrentVersion","dataVersion"]

%>package ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )};

import ${config.basePackage}.domain.BasicDomain;
import java.io.Serializable;
/**
 * ${tableDefine.cnname} Domain 类
 * @author ${config.author}
 * @date ${config.nowDate}
 */
public class ${tableDefine.id} extends BasicDomain implements Serializable {
	
  private static final long serialVersionUID = ${PubUtils.getRandomLong()}L;
	
<%
	  columns.each{
		  if(!excludes.contains(it.dataName)) {
			  println "	/**  ${it.cnname}  */";
			  println "	private ${tableNameUtil.getDataType(it.columnType)} ${it.dataName}; "
		  }
	  };
	  
	  columns.each{
		  if(!excludes.contains(it.dataName)) {
			  String dataName = it.dataName

			  def upperFistName=tableNameUtil.upperFirst(dataName)
			  def dataType =tableNameUtil.getDataType(it.columnType)
			  println """
  	public void set${upperFistName}(${dataType} ${dataName}) {
  	  this.${dataName}=${dataName};
  	}
  
  	public ${dataType} get${upperFistName}() {
  	  return this.${dataName};
  	}"""
		  }
	  }
%>

}
