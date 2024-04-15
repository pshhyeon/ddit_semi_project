package ddit.util;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisUtil {
	private static SqlSessionFactory sqlSessionFactory = null;

	static {
		// mybatis의 환경설정파일(mybatis-config.xml)을 읽어와서 처리하기
		InputStream in = null;
		try {
			// 환경 설정 파일을 읽어올 스트림 객체 생성
			in = Resources.getResourceAsStream("ddit/mybatis/config/mybatis-config.xml");
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(in);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("MyBatis initialization failed");
			e.printStackTrace();
		} finally {
			// 스트림 닫기
			if (in != null) try { in.close(); } catch (IOException e) { e.printStackTrace(); }
		} // /finally
		// /mybatis-config.xml 환경설정
	}

	// SqlSession 객체를 생성해서 반환하는 메서드
	public static SqlSession getSqlSession() {
		return sqlSessionFactory.openSession();
	}
}
