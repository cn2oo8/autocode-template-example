<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def managerName = varDomainName+"Manager";
  def pkColumn=tableDefine.getPkColumn();
  def pkJavaType=tableNameUtil.getDataType(pkColumn?.columnType); 
  
%>package ${config.basePackage}.service${PubUtils.addStrAfterSeparator(config.category,"." )}.impl;



import javax.annotation.Resource;
import java.util.List;
import java.util.Date;
import org.springframework.stereotype.Service;
import org.apache.log4j.Logger;
import ${config.basePackage}.common.PageQuery;
import ${config.basePackage}.common.CommonResult;
import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id};
import ${config.basePackage}.manager${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}Manager;
import ${config.basePackage}.service${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}Service;

/**
 * ${tableDefine.cnname}service实现
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
@Service("${varDomainName}Service")
public class ${tableDefine.id}ServiceImpl implements ${tableDefine.id}Service {

	private static final Logger logger = Logger.getLogger(${tableDefine.id}ServiceImpl.class);
	
	@Resource(name="${managerName}")
	private ${tableDefine.id}Manager ${managerName};
    
    public CommonResult<${tableDefine.id}> add(${tableDefine.id} ${varDomainName}) {
		CommonResult<${tableDefine.id}> result = new CommonResult<${tableDefine.id}>();
		try{
			<%
				if(tableModel.createTime){
					def column=tableDefine.getColumnByColumnName(tableModel.createTime);
					if(column.columnType!='TIMESTAMP'){
						def timeDataName=tableNameUtil.convertToBeanNames(tableModel.createTime);
						def upperFistTimeName=tableNameUtil.upperFirst(timeDataName);
			%>
			${varDomainName}.set${upperFistTimeName}(new Date());
			<%
					}

				}
			%>
			<%
				if(tableModel.updateTime){
					def column=tableDefine.getColumnByColumnName(tableModel.updateTime);
					if(column.columnType!='TIMESTAMP'){
						def timeDataName=tableNameUtil.convertToBeanNames(tableModel.updateTime);
						def upperFistTimeName=tableNameUtil.upperFirst(timeDataName);
			%>
			${varDomainName}.set${upperFistTimeName}(new Date());
			<%
					}

				}
			%>
			result.addDefaultModel(${managerName}.add(${varDomainName}));
			result.setSuccess(true);
		} catch (Exception e) {
			logger.error("添加 ${tableDefine.cnname}失败", e);
			result.setSuccess(false);
		}
		return result;
	}
	
	public CommonResult<${tableDefine.id}> update(${tableDefine.id} ${varDomainName}) {
		CommonResult<${tableDefine.id}> result = new CommonResult<${tableDefine.id}>();
		try {
			<%
			 if(tableModel.updateTime){
				 def column=tableDefine.getColumnByColumnName(tableModel.updateTime);
				if(column.columnType!='TIMESTAMP'){
					def timeDataName=tableNameUtil.convertToBeanNames(tableModel.updateTime);
					def upperFistTimeName=tableNameUtil.upperFirst(timeDataName);
			        %>
					${varDomainName}.set${upperFistTimeName}(new Date());
					<%
				}

			      }
			%>
			${managerName}.update(${varDomainName});
			result.setSuccess(true);
		} catch (Exception e) {
			logger.error("更新 ${tableDefine.cnname}失败", e);
			result.setSuccess(false);
		}
		return result;
	}
	
   <%
      if(pkColumn!=null){
    %>

	public CommonResult<${tableDefine.id}> deleteByPk(${tableDefine.id} ${varDomainName}) {
		CommonResult<${tableDefine.id}> result = new CommonResult<${tableDefine.id}>();
		try {
			${managerName}.deleteByPk( ${varDomainName});
			result.setSuccess(true);
		} catch (Exception e) {
			logger.error("删除 ${tableDefine.cnname}失败", e);
			result.setSuccess(false);
		}
		return result;
    }


    	public CommonResult<${tableDefine.id}> getByPk(${pkJavaType} ${pkColumn.dataName}) {
		CommonResult<${tableDefine.id}> result = new CommonResult<${tableDefine.id}>();
		try {
			result.addDefaultModel("${varDomainName}", ${managerName}.getByPk(${pkColumn.dataName}));
			result.setSuccess(true);
		} catch (Exception e) {
			logger.error("根据主键获取 ${tableDefine.cnname}失败", e);
			result.setSuccess(false);
		}
		return result;
	}
	

        <%
	}
	%>
	


	public CommonResult<${tableDefine.id}> getUnique(${tableDefine.id} ${varDomainName}) {
		CommonResult<${tableDefine.id}> result = new CommonResult<${tableDefine.id}>();
		try {
			result.addDefaultModel(${managerName}.getUnique(${varDomainName}));
			result.setSuccess(true);
		} catch (Exception e) {
			logger.error("根据example获取唯一 ${tableDefine.cnname}失败", e);
			result.setSuccess(false);
		}
		return result;
	}


	public CommonResult<List<${tableDefine.id}>> getListByExample(${tableDefine.id} ${varDomainName}) {
		CommonResult<List<${tableDefine.id}>> result = new CommonResult<List<${tableDefine.id}>>();
		try {
			List<${tableDefine.id}> list = ${managerName}.getListByExample(${varDomainName});
			result.addDefaultModel("list", list);
			result.setSuccess(true);
		} catch (Exception e) {
			logger.error("取得 ${tableDefine.cnname}失败", e);
			result.setSuccess(false);
		}
		return result;
	}

	
	public CommonResult<List<${tableDefine.id}>> getByPage(PageQuery pageQuery) {
		CommonResult<List<${tableDefine.id}>> result = new CommonResult<List<${tableDefine.id}>>();
		try {
			Long totalCount = this.count(pageQuery);
			if (totalCount > 0) {
				pageQuery.setTotalCount(totalCount);
				List<${tableDefine.id}> list = ${managerName}.getByPage(pageQuery);
				result.addDefaultModel("list", list);
				result.addModel("pageQuery", pageQuery);
			}
			result.setSuccess(true);
		} catch (Exception e) {
			logger.error("分页获取 ${tableDefine.cnname}失败", e);
			result.setSuccess(false);
		}
		return result;
	}
	
	public Long count(PageQuery pageQuery) {
		return ${managerName}.count(pageQuery);
	}


	/******* getter and setter ***/
	public ${tableDefine.id}Manager get${tableDefine.id}Manager() {
		return ${varDomainName}Manager;
	}

	public void set${tableDefine.id}Manager(${tableDefine.id}Manager ${varDomainName}Manager) {
		this.${varDomainName}Manager = ${varDomainName}Manager;
	}

}
