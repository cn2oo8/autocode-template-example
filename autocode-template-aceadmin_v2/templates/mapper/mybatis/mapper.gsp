<%

 def columns=tableDefine.columns;
 def mapName=tableDefine.id+"-Map";
 def cnt=0;
 def pkColumn=tableDefine.getPkColumn();
 def pkJavaType=tableNameUtil.getFullDataType(pkColumn?.columnType);
 Set updateExcludes = ["id","creator","created","modified","concurrentVersion"]
%><?xml version="1.0" encoding="UTF-8" ?> 
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${config.basePackage}.dao${PubUtils.addStrAfterSeparator(config.category,"." )}.${tableDefine.id}Dao">

  <resultMap id="${tableDefine.id}-Map" type="${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}">
 <%
     def columnNames=[];
     def dataNames=[];
 	  columns.each{
		  println """		<id property="${it.dataName}" column="${it.columnName}"/>""";
			if(it.getIsPK()){
				if(extendConf["autoKey"]!="true"){
					dataNames.add(it.dataName);
					columnNames.add(it.columnName);
				}
			}else{
					dataNames.add(it.dataName);
					columnNames.add(it.columnName);
			}


}%>
	</resultMap>


	<!-- 可以包含bean里面没有的字段-->
	<sql id="MAP-COMMON-SQL">
		<where>
		<%
			columns.each{
		%>	<if test="${it.dataName} != null"> AND ${it.columnName} = #{${it.dataName}}</if>
		<%
		 }
		%></where>
	</sql>

	<sql id="ORDER-SQL">
		<choose>
			<when test="orderBy != null and orderBy != '' and sortType != null and sortType != ''">
				ORDER BY \${orderBy} \${sortType}
			</when>
			<otherwise>
				<%
					def orderColumns=tableModel.orderColumns;
					if(orderColumns!=null&&orderColumns.size()!=0){
						print "ORDER BY ";
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
			</otherwise>
		</choose>
	</sql>


	<sql id="All-FIELDS">
		${tableModel.getBizFields('allColumn')}
	</sql>

	<insert id="add" parameterType="${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}"
			<% if(pkColumn!=null){ %> keyProperty="${pkColumn.dataName}" useGeneratedKeys="true" <%}%>>
		INSERT INTO ${tableDefine.dbTableName} (${PubUtils.listToStr(columnNames)})
			VALUES(<%
			 cnt=1;
			 dataNames.each{
			    if(cnt==dataNames.size())
				print "#{"+it+"}"
			    else print "#{"+it+"},"
			    cnt++;
			 }
			%>)
	 </insert>


	<!-- 批量添加数据  -->
	<insert id="batchAdd" parameterType="java.util.List">
		INSERT INTO ${tableDefine.dbTableName} (${PubUtils.listToStr(columnNames)})
		VALUES
		<foreach collection="list" item="item" index="index" separator=",">
			(<%
				cnt=1;
				dataNames.each{
					if(cnt==dataNames.size())
						print "#{item."+it+"}"
					else print "#{item."+it+"},"
					cnt++;
				}
			%>)
		</foreach>
	</insert>

    <update id="update" parameterType="${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}" >
    	UPDATE  ${tableDefine.dbTableName}
		<set>
<%
	columns.each{
		if(updateExcludes.contains(it.dataName)){
			return
		}
	    if(pkColumn!=it){
	   	   print """			<if test="${it.dataName} !=null"> ${it.columnName} = #{${it.dataName}},</if>\n"""
	   	}
    }
%>			concurrent_version = concurrent_version + 1
		</set>
	 	WHERE ${pkColumn.columnName} = #{${pkColumn.dataName}}
  	</update>


    <%
      if(pkColumn!=null){
    %>

	<delete id="deleteByPk" parameterType="${config.basePackage}.domain${PubUtils.addStrAfterSeparator(config.category,".")}.${tableDefine.id}">
		DELETE FROM ${tableDefine.dbTableName} WHERE ${pkColumn.columnName} = #{${pkColumn.dataName}}
	</delete>

	<select id="getByPk" resultMap="$mapName" parameterType="${pkJavaType}">
		SELECT  <include refid="All-FIELDS"/> FROM ${tableDefine.dbTableName}	WHERE ${pkColumn.columnName} = #{${pkColumn.dataName}}
	</select>
    <%}%>

	<select id="getListByExample" resultMap="$mapName" parameterType="java.util.HashMap">
		SELECT   <include refid="All-FIELDS"/> FROM ${tableDefine.dbTableName}
		<include refid="MAP-COMMON-SQL" /> LIMIT 0,1000
	</select>


	<select id="queryByPage" resultMap="$mapName" parameterType="java.util.HashMap">
			SELECT  <include refid="All-FIELDS"/> FROM ${tableDefine.dbTableName}
            <include refid="MAP-COMMON-SQL" />
            <include refid="ORDER-SQL" />
		LIMIT #{startIndex},#{pageSize}
	</select>

	<select id="count" resultType="java.lang.Long" parameterType="java.util.HashMap">
		<![CDATA[
			SELECT COUNT(1) FROM ${tableDefine.dbTableName}
		]]>
		<include refid="MAP-COMMON-SQL" />
	</select>



</mapper>