<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def pkColumn=tableDefine.getPkColumn();
  def pkJavaType=tableNameUtil.getDataType(pkColumn?.columnType);
  def ns=tableDefine.id;
%>
package ${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,"." )}.impl;

import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;
import ${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}Dao;
import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id};
import java.util.Map;

/**
 *${tableDefine.cnname} Dao实现类
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 *
 */
@Repository("${varDomainName}Dao")
public class ${tableDefine.id}DaoImpl  extends SqlMapClientTemplate implements ${tableDefine.id}Dao {

	    public static final String ADD = "${ns}.add";
	    public static final String UPDATE = "${ns}.update";
	    public static final String DELETE = "${ns}.delete";
        public static final String GET_BY_EXAMPLE = "${ns}.getByExample";
	    public static final String GET_BY_ID = "${ns}.getById";
	    public static final String GET_BY_PAGE = "${ns}.getByPage";
	    public static final String COUNT = "${ns}.count";
	
	
	/**
	 * 新增
	 */
	
	public ${tableDefine.id} add(${tableDefine.id} ${varDomainName}) {
    		this.insert(ADD, ${varDomainName});
    		return ${varDomainName};
    }
    
   	/**
	 * 更新
	 */
    public void update(${tableDefine.id} ${varDomainName}) {
    	this.update(UPDATE, ${varDomainName});
    }
    
    <%
      if(pkColumn!=null){
    %>	
    /**
	 * 删除
	 */
    public void deleteByPk(${pkJavaType} ${pkColumn.dataName}) {
    	this.update(DELETE, ${pkColumn.dataName});
    }

    public ${tableDefine.id} getByPk(${pkJavaType} ${pkColumn.dataName}) {
    	return (${tableDefine.id}) this.queryForObject(GET_BY_ID, ${pkColumn.dataName});
    }

    <% } %>

    
    public List<${tableDefine.id}> getListByExample(${tableDefine.id} ${varDomainName}) {
        return this.queryForList(GET_BY_EXAMPLE, ${varDomainName});
    }
      
    /**
	 * 获得分页数据
	 *@param params 查询参数类
	 *@return 
	 */
    @SuppressWarnings("unchecked")
    public List<${tableDefine.id}> getByPage(Map<String,Object> params) {
    	return this.queryForList(GET_BY_PAGE, params);
    }
    	
    public int count(Map<String,Object> params) {
    	return (Integer)this.queryForObject(COUNT, params);
    }

}
