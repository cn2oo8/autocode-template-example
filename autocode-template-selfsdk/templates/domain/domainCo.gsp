<%
	  def tableDefine=tableModel.tableDefine;
	  def columns=tableDefine.columns;
	  def isSpringMvc="true".equals(extendConf.get("springMvc"))
	  Set excludes = []

%>package ${config.basePackage}.sdk.co${PubUtils.addStrAfterSeparator(config.category,"." )};

import java.io.Serializable;
import com.google.gson.annotations.SerializedName;
/**
 * ${tableDefine.cnname} Domain 类
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
public class ${tableDefine.id}Co implements Serializable {
	
  private static final long serialVersionUID = ${PubUtils.getRandomLong()}L;
	
<%
	  columns.each{
		  if(!excludes.contains(it.dataName)) {
			  println "	/**  ${it.cnname}  */"
			  println """	@SerializedName("${it.columnName}")"""
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
