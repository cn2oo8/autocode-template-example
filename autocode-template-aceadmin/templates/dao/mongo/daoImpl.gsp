/**
 * Copyright(c) 2013-  www.shareyi.com
 *
 */
<%
  def varDomainName=tableNameUtil.lowerCaseFirst(tableDefine.id);
%>
package ${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,"." )}.impl;

import java.util.List;

import org.springframework.stereotype.Repository;
import ${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}Dao;
import ${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id};
import ${config.basePackage}.mongohelper.BaseMongoDao;

/**
 * ${tableDefine.cnname} Dao实现类
 *
 * @author ${config.author}
 * @date ${config.nowDate}
 *
 */
@Repository("${varDomainName}Dao")
public class ${tableDefine.id}DaoImpl  extends BaseMongoDao< ${tableDefine.id}> implements ${tableDefine.id}Dao {

     public ${tableDefine.id}DaoImpl(){
        setCollectionName("${tableDefine.dbTableName}");
     }

}
