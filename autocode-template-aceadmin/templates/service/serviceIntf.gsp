<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def pkColumn=tableDefine.getPkColumn();
  def pkJavaType=tableNameUtil.getDataType(pkColumn?.columnType);
%>package ${config.basePackage}.service${PubUtils.addStrAfterSeparator(config.category,".")};

import java.util.List;
import ${config.basePackage}.common.PageQuery;
import ${config.basePackage}.common.CommonResult;
import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${tableDefine.id};

/**
 * jshow ${tableDefine.cnname}service 接口
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
public interface ${tableDefine.id}Service {
   
    /**
     * 添加并返回设置id的${tableDefine.id}对象
     * 
     * @param ${varDomainName}
     * @return
     */
    public CommonResult<${tableDefine.id}> add(${tableDefine.id} ${varDomainName});
    
	/**
     * 更新${tableDefine.id}
     * 
     * @param ${varDomainName}
     */
    public CommonResult<${tableDefine.id}> update(${tableDefine.id} ${varDomainName});

    <%
      if(pkColumn!=null){
    %>
	 /**
     * 根据主键删除${tableDefine.id}
     * 
     * @param ${pkColumn.dataName}
     */
    public CommonResult<${tableDefine.id}> deleteByPk(${pkJavaType} ${pkColumn.dataName});

	/**
     * 根据主键获取${tableDefine.id}
     * 
     * @param ${pkColumn.dataName}
     * @return
     */	
    public CommonResult<${tableDefine.id}> getByPk(${pkJavaType} ${pkColumn.dataName});
     <%
       }
	%>
    
	/**
     * 根据example取得唯一的${tableDefine.id}
     * 
     * @param ${varDomainName}
     * @return
     */
    public CommonResult<${tableDefine.id}> getUnique(${tableDefine.id} ${varDomainName});

    /**
     * 根据example取得${tableDefine.id}列表
     * 
     * @param  ${varDomainName}
     * @return
     */
    public CommonResult<List<${tableDefine.id}>> getListByExample(${tableDefine.id} ${varDomainName});

	/**
     * 分页取得${tableDefine.id}列表
     * 
     * @param pageQuery
     * @return
     */
    public CommonResult<List<${tableDefine.id}>> getByPage(PageQuery pageQuery);
	
	/**
     * 根据查询条件返回数量
     * 
     * @param pageQuery
     * @return
     */
    public int count(PageQuery pageQuery);

}
