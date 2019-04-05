<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def serviceName=varDomainName+"Service";
  def pkColumn=tableDefine.getPkColumn();
  def pkUpperFistName=tableNameUtil.upperFirst(pkColumn?.dataName);
%>package ${config.basePackage}.controller${PubUtils.addStrAfterSeparator(config.category,".")};


import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import ${config.basePackage}.controller.AbstractController;
import ${config.basePackage}.service${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}Service;
import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id};
import javax.servlet.http.HttpServletRequest;
import ${config.basePackage}.common.web.PageQuery;

/**
 *${tableDefine.cnname} controller
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@Controller
@RequestMapping("${PubUtils.addStrAfterSeparator(PubUtils.packageToPath(config.category),"/")}/${varDomainName}")
public class ${tableDefine.id}Controller extends AbstractController<${tableDefine.id}> {

	@Resource(name="${varDomainName}Service")
	private ${tableDefine.id}Service ${varDomainName}Service;

	public ${tableDefine.id}Service getService() {
	 return ${varDomainName}Service;
	}
}
