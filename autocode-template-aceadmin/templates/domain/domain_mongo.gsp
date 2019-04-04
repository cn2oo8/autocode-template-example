<%
	  def tableDefine=tableModel.tableDefine;
	  def columns=tableDefine.columns;
%>package ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )};

import java.io.Serializable;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 * ${tableDefine.cnname} Domain 类
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@Document(collection = "${tableDefine.dbTableName}")
public class ${tableDefine.id}  implements Serializable {
	
  private static final long serialVersionUID = ${PubUtils.getRandomLong()}L;
	
<%
	  columns.each{
	  println "	/**  ${it.cnname}  */";
	  if(it.getIsPK()){
		  println "\t@Id";
	  }
	  println "	private ${tableNameUtil.getDataType(it.columnType)} ${it.dataName}; ";
	  };
	  
	  
	  columns.each{
	  String dataName=it.dataName;
	  def upperFistName=tableNameUtil.upperFirst(dataName);
	  def dataType=tableNameUtil.getDataType(it.columnType);
	  println """
  	public void set${upperFistName}(${dataType} ${dataName}) {
  	  this.${dataName}=${dataName};
  	}
  
  	public ${dataType} get${upperFistName}() {
  	  return this.${dataName};
  	}
	
	  	""";
	  };
%>
}
