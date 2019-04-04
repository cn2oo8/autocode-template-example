${snippetTemplateUtil.getTemplate('copyrightInfo')}
<%
    def tableDefine = tableModel.tableDefine;
    def columns = tableDefine.columns;
    Set excludes = ["router","platform","id","status","operator","creator","created","modified","concurrentVersion","dataVersion"]
%>package ${config.basePackage}.sdk.domain${PubUtils.addStrAfterSeparator(config.category,"." )};

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import java.io.Serializable;
/**
 * ${tableDefine.cnname} 接口dto 类
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@Setter
@Getter
@ToString(doNotUseGetters = true,callSuper = true)
public class ${tableDefine.id}Dto extends BasicDto implements Serializable {
    private static final long serialVersionUID = ${PubUtils.getRandomLong()}L;

<% columns.each {
    if(!excludes.contains(it.dataName)) {
%>
    /**  ${it.cnname}  **/
    private ${tableNameUtil.getDataType(it.columnType)} ${it.dataName};
<%  }
}%>

}
