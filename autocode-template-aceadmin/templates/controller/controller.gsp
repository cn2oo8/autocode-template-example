${snippetTemplateUtil.getTemplate('copyrightInfo')}

 <%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def serviceName=varDomainName+"Service";
  def pkColumn=tableDefine.getPkColumn();
  def pkUpperFistName=tableNameUtil.upperFirst(pkColumn?.dataName);

%>package ${config.basePackage}.controller${PubUtils.addStrAfterSeparator(config.category,".")};

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ${config.basePackage}.common.CommonResult;
import ${config.basePackage}.common.PageQuery;
import ${config.basePackage}.web.base.BaseController;
import ${config.basePackage}.service${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}Service;
import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id};

/**
 *${tableDefine.cnname} controller
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@Controller
@RequestMapping("${PubUtils.addStrAfterSeparator(PubUtils.packageToPath(config.category),"/")}/${varDomainName}")
public class ${tableDefine.id}Controller extends BaseController {

	@Resource(name="${varDomainName}Service")
	private ${tableDefine.id}Service ${varDomainName}Service;


	@RequestMapping(value="manage",method={RequestMethod.GET,RequestMethod.POST})
	public String manage(){
		return "${PubUtils.packageToPath(config.category)}/${varDomainName}/manage";
	}

	
	@RequestMapping(value="add",method={RequestMethod.GET,RequestMethod.POST})
    public String add() {
		return "${PubUtils.packageToPath(config.category)}/${varDomainName}/add";
    }
    
	
	@RequestMapping(value="doAdd",method={RequestMethod.GET,RequestMethod.POST})
	 public @ResponseBody Map<String,Object> doAdd(${tableDefine.id} ${varDomainName}, ModelMap context) {
	    		CommonResult<${tableDefine.id}> result =${serviceName}.add(${varDomainName});
				return result.getReturnMap();
	    }
	 
	 

		@RequestMapping(value="update",method={RequestMethod.GET,RequestMethod.POST})
	    public String update(${tableDefine.id} ${varDomainName}, ModelMap context) {
			CommonResult<${tableDefine.id}> result = ${serviceName}.getByPk(${varDomainName}.get${pkUpperFistName}());
			this.toVm(result, context);
			return "${PubUtils.packageToPath(config.category)}/${varDomainName}/update";
	    }
	    
		
		@RequestMapping(value="doUpdate",method={RequestMethod.GET,RequestMethod.POST})
	    public @ResponseBody Map<String,Object> doUpdate(${tableDefine.id} ${varDomainName}, ModelMap context) {
			CommonResult<${tableDefine.id}> result = ${serviceName}.update(${varDomainName});
			return result.getReturnMap();
	    }
	    

		@RequestMapping(value="view",method={RequestMethod.GET,RequestMethod.POST})
		public String view(${tableDefine.id} ${varDomainName}, ModelMap context) {
			CommonResult<${tableDefine.id}> result = ${serviceName}.getByPk(${varDomainName}.get${pkUpperFistName}());
			this.toVm(result, context);
			return "${PubUtils.packageToPath(config.category)}/${varDomainName}/view";
	    }
	   
		
		@RequestMapping(value="doDelete",method={RequestMethod.GET,RequestMethod.POST})
	    public @ResponseBody  Map<String,Object>  doDelete(${tableDefine.id} ${varDomainName}) {
			CommonResult<${tableDefine.id}> result =${serviceName}.deleteByPk(${varDomainName}.get${pkUpperFistName}());
			return result.getReturnMap();
	    }
	    
		@RequestMapping(value="list",method={RequestMethod.GET,RequestMethod.POST})
	    public String list(HttpServletRequest request, ModelMap context) {
			int pageSize = this.getPageSize(request,20,200);
            PageQuery pageQuery=new PageQuery(request,pageSize);
            CommonResult<List<${tableDefine.id}>> result = ${serviceName}.getByPage(pageQuery);
			this.toVm(result, context);
			return "${PubUtils.packageToPath(config.category)}/${varDomainName}/list";
	    }


}
