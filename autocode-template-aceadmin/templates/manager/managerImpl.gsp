<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
  def pkColumn=tableDefine.getPkColumn();
  def pkJavaType=tableNameUtil.getDataType(pkColumn?.columnType);
%>package ${config.basePackage}.manager${PubUtils.addStrAfterSeparator(config.category,"." )}.impl;

import org.springframework.stereotype.Component;
import javax.annotation.Resource;
import java.util.List;
import ${config.basePackage}.common.PageQuery;
import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id};
import ${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}Dao;
import ${config.basePackage}.manager${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}Manager;

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
		int i=${varDomainName}Dao.add(${varDomainName});
		return ${varDomainName};
    }
    
    public void update(${tableDefine.id} ${varDomainName}) {
		${varDomainName}Dao.update(${varDomainName});
    }
    

    <%
      if(pkColumn!=null){
    %>
    public void deleteByPk(${pkJavaType} ${pkColumn.dataName}) {
		${varDomainName}Dao.deleteByPk(${pkColumn.dataName});
    }


    public ${tableDefine.id} getByPk(${pkJavaType} ${pkColumn.dataName}) {
		return ${varDomainName}Dao.getByPk(${pkColumn.dataName});
    }
    
   <%}%>


    	
   
   public ${tableDefine.id} getUnique(${tableDefine.id} ${varDomainName}) {
		return ${varDomainName}Dao.getUnique(${varDomainName});
    }

    
 public List<${tableDefine.id}> getListByExample(${tableDefine.id} ${varDomainName}) {
    return ${varDomainName}Dao.getListByExample(${varDomainName});
    }

    
    public List<${tableDefine.id}> getByPage(PageQuery pageQuery) {
		return ${varDomainName}Dao.getByPage( pageQuery.getParams());
    }
    	
    public int count(PageQuery pageQuery) {
		return ${varDomainName}Dao.count( pageQuery.getParams());
    }

    /******* getter and setter ***/
    
	public ${tableDefine.id}Dao get${tableDefine.id}Dao() {
		return ${varDomainName}Dao;
	}

	public void set${tableDefine.id}Dao(${tableDefine.id}Dao ${varDomainName}Dao) {
		this.${varDomainName}Dao = ${varDomainName}Dao;
	}
}
