<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def pkColumn=tableDefine.getPkColumn();
  def pkJavaType=tableNameUtil.getDataType(pkColumn?.columnType);
%>package ${config.basePackage}.manager${PubUtils.addStrAfterSeparator(config.category,"." )}.impl;

import org.springframework.stereotype.Component;
import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import ${config.basePackage}.common.PageQuery;
import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id};
import ${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}Dao;
import ${config.basePackage}.manager${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}Manager;
import ${config.basePackage}.mongohelper.utils.ObjectParams;
import org.springframework.data.mongodb.core.query.Query;

/**
 * ${tableDefine.cnname}Manager实现类
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 */
 @Component("${varDomainName}Manager")
public class ${tableDefine.id}ManagerImpl implements ${tableDefine.id}Manager {

	@Resource(name="${varDomainName}Dao")
	private ${tableDefine.id}Dao ${varDomainName}Dao;


  public ${tableDefine.id} add(${tableDefine.id} ${varDomainName}) {
		${varDomainName}Dao.insert(${varDomainName});
		return ${varDomainName};
    }
    
    public void update(${tableDefine.id} ${varDomainName}) {
		${varDomainName}Dao.update(${varDomainName});
    }
    

    <%
      if(pkColumn!=null){
    %>
    public void deleteByPk(${tableDefine.id} ${varDomainName}) {
		${varDomainName}Dao.remove(${varDomainName});
    }


    public ${tableDefine.id} getByPk(${pkJavaType} ${pkColumn.dataName}) {
		return ${varDomainName}Dao.findById(${pkColumn.dataName});
    }
    
   <%}%>


    	
   
   public ${tableDefine.id} getUnique(${tableDefine.id} ${varDomainName}) {
		Query query=ObjectParams.buildQueryObject(${varDomainName});
        return ${varDomainName}Dao.findOne(query);
    }

    
 public List<${tableDefine.id}> getListByExample(${tableDefine.id} ${varDomainName}) {
        Query query= ObjectParams.buildQueryObject(${varDomainName});
        return ${varDomainName}Dao.findList(query);
    }

    
    public List<${tableDefine.id}> getByPage(PageQuery pageQuery) {
        Map<String,Object> param=pageQuery.getParams();
        Query query=ObjectParams.buildQueryMap(ObjectParams.getClassParam(param,${tableDefine.id}.class));
        return ${varDomainName}Dao.findByPage(query,pageQuery.getStartIndex(),pageQuery.getPageSize());
    }
    	
    public Long count(PageQuery pageQuery) {
		 Map<String,Object> param=pageQuery.getParams();
        Query query=ObjectParams.buildQueryMap(ObjectParams.getClassParam(param,${tableDefine.id}.class));
        return ${varDomainName}Dao.count(query);
    }

    /******* getter and setter ***/
    
	public ${tableDefine.id}Dao get${tableDefine.id}Dao() {
		return ${varDomainName}Dao;
	}

	public void set${tableDefine.id}Dao(${tableDefine.id}Dao ${varDomainName}Dao) {
		this.${varDomainName}Dao = ${varDomainName}Dao;
	}
}
