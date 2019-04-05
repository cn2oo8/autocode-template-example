<%
	  def tableDefine=tableModel.tableDefine;
	  def columns=tableDefine.columns;
	  def isSpringMvc="true".equals(extendConf.get("springMvc"));
%>package ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )};

import java.io.Serializable;
<%
  //spring日期转换类引入判断
  if(isSpringMvc && (tableModel.listContainsTag('date') || tableModel.listContainsTag('datetime') )){
  	println "import org.springframework.format.annotation.DateTimeFormat;";
  }
%>

/**
 * ${tableDefine.cnname} Domain 类
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
public class ${tableDefine.id}  implements Serializable {
	
  private static final long serialVersionUID = ${PubUtils.getRandomLong()}L;
	
<%
	  columns.each{
	  	println "	/**  ${it.cnname}  */";
	  	if(isSpringMvc){
	  		if("date".equalsIgnoreCase(it.jspTag)){
	  		 println """	@DateTimeFormat(pattern="yyyy-MM-dd")""";
	  		}else if("datetime".equalsIgnoreCase(it.jspTag)){
	  		 println """	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")""";
	  		}
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
