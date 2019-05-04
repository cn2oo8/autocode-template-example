<%
 
 def columns=tableDefine.columns;
 def mapName=tableDefine.id+"-Map";
 def pkColumn=tableDefine.getPkColumn();
 def pkJavaType=tableNameUtil.getFullDataType(pkColumn?.columnType);
 def cnt=0;
%><?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE sqlMap PUBLIC "-//iBATIS.com//DTD SQL Map 2.0//EN"
        "http://ibatis.apache.org/dtd/sql-map-2.dtd">

<sqlMap namespace="${tableDefine.id}">

    <typeAlias alias="${tableDefine.id}" type="${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,"." )}.${tableDefine.id}"/>


  <resultMap id="${tableDefine.id}-Map" class="${tableDefine.id}">
 <%
     def columnNames=[];
     def dataNames=[];
 	  columns.each{
			println """		<result property="${it.dataName}" column="${it.columnName}"/>""";   
			dataNames.add(it.dataName);
			columnNames.add(it.columnName);     
}%>
	</resultMap>

	
	
	<sql id="COMMON-SQL">	
	 <%
   List<String> list=tableModel.getSearchKeyList();
   if(list.size()!=0)
 	{
 	%>  
		<dynamic prepend=" WHERE ">
		<%
		  list.each{
		%>
		<isNotNull prepend=" AND " property="${tableNameUtil.convertToBeanNames(it)}">
				${it} = #${tableNameUtil.convertToBeanNames(it)}#
		</isNotNull><%
		 }
		%>	
		</dynamic>
	 <%
	 }
	 %>	
	</sql>
	
	<sql id="ORDER-SQL">
	 <%
	 def orderColumns=tableModel.orderColumns;
	 if(orderColumns!=null&&orderColumns.size()!=0){
	 	print "order by ";
	 	int i=0;
	 	orderColumns.each{
	 		print """${it.columnName} ${it.orderType}"""
	 		i++;
	 		if(i!=orderColumns.size()){
	 			print ",";
	 		}
	 	}
	 }
	 %>
	</sql>


	<sql id="All-FIELDS">
		${tableModel.getBizFields('allColumn')}
	</sql>
	
	<insert id="add" parameterClass="${tableDefine.id}">
        insert into ${tableDefine.dbTableName} (${PubUtils.listToStr(columnNames)})
		values(<%
		 cnt=1;
		 dataNames.each{
		    if(cnt==dataNames.size())
		    	print "#"+it+"#"
		    else print "#"+it+"#,"
		    cnt++;
		 }
		%>)
    <%
      if(pkColumn!=null){
    %>
        <selectKey resultClass="${pkJavaType}" keyProperty="${pkColumn.dataName}">
           select last_insert_id() as ID from ${tableDefine.dbTableName} limit 1
        </selectKey> 
    <%}%>
    </insert>

    
    <update id="update" parameterClass="${tableDefine.id}" >
    	update  ${tableDefine.dbTableName} 	
    	set <%
    	   cnt=1;
    	   columns.each{
	    if(pkColumn!=it){      
    		 print """${it.columnName} = #${it.dataName}#"""
    		 if(cnt!=columns.size())
    		 print ","
		}
    		cnt++;
    	  }
    	%>
	 where ${pkColumn.columnName} = #${pkColumn.dataName}#
  	</update>
  	
    <%
      if(pkColumn!=null){
    %>	
    <delete id="delete" parameterClass="${pkJavaType}">
       	delete from ${tableDefine.dbTableName}
       	where ${pkColumn.columnName} = #${pkColumn.dataName}#
    </delete>
    

    	<select id="getById" resultMap="$mapName" parameterClass="${pkJavaType}">
		SELECT  <include refid="All-FIELDS"/> FROM ${tableDefine.dbTableName}	WHERE ${pkColumn.columnName} = #${pkColumn.dataName}#
	</select>
    <%}%>





	<select id="getUnique" resultMap="$mapName" parameterType="${tableDefine.id}">
		SELECT   <include refid="All-FIELDS"/> FROM ${tableDefine.dbTableName}
		<include refid="COMMON-SQL" /> limit 1
	</select>



	<select id="getByExample" resultMap="$mapName" parameterClass="${tableDefine.id}">
		SELECT   <include refid="All-FIELDS"/>  FROM ${tableDefine.dbTableName}
		<isParameterPresent>   
            <include refid="COMMON-SQL" />
        </isParameterPresent>
	</select>


	<select id="getByPage" resultMap="$mapName" parameterClass="java.util.HashMap">
		SELECT  <include refid="All-FIELDS"/> FROM ${tableDefine.dbTableName}
		<isParameterPresent>   
            <include refid="COMMON-SQL" />
        </isParameterPresent>
         <include refid="ORDER-SQL" />
		LIMIT #startIndex#,#pageSize#
	</select>
	

	<select id="count" resultClass="java.lang.Integer" parameterClass="java.util.HashMap">
		<![CDATA[
			SELECT COUNT(1) FROM ${tableDefine.dbTableName}
		]]>
		<isParameterPresent>   
            <include refid="COMMON-SQL" />
        </isParameterPresent>
	</select>
	


</sqlMap>