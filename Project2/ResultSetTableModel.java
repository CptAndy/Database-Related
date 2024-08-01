import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.table.AbstractTableModel;
import com.mysql.cj.jdbc.MysqlDataSource;

/*
 * Name: Anderson Mota Course: CNT 4714 Summer 2024 Assignment title: Project 2 – Result Set Table
 * Model with modification(s) Date: July 7, 2024 Class: Enterprise Computing
 */
public class ResultSetTableModel extends AbstractTableModel {
  private Connection connection;
  private Statement statement;
  private ResultSet resultSet;
  private ResultSetMetaData metaData;
  private int numberOfRows;
  private boolean connectedToDatabase = false;

  //Modified to have 3 variables to handle to simplify whats going on 
  //url from url.properties
  //username and password come from user.properties
  public ResultSetTableModel(String url, String username, String password)
      throws SQLException, ClassNotFoundException {
    MysqlDataSource dataSource = new MysqlDataSource();
    dataSource.setURL(url);
    dataSource.setUser(username);
    dataSource.setPassword(password);

    connection = dataSource.getConnection();
    statement =
        connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY,ResultSet.HOLD_CURSORS_OVER_COMMIT);
    connectedToDatabase = true;
  }

//get class that represents column type
  public Class getColumnClass( int column ) throws IllegalStateException
  {
     // ensure database connection is available
     if ( !connectedToDatabase ) 
        throw new IllegalStateException( "Not Connected to Database" );

     // determine Java class of column
     try 
     {
        String className = metaData.getColumnClassName( column + 1 );
        
        // return Class object that represents className
        return Class.forName( className );
     } // end try
     catch ( Exception exception ) 
     {
        exception.printStackTrace();
     } // end catch
     
     return Object.class; // if problems occur above, assume type Object
  } // end method getColumnClass

  // get number of columns in ResultSet
  public int getColumnCount() throws IllegalStateException {
    // ensure database connection is available
    if (!connectedToDatabase)
      throw new IllegalStateException("Not Connected to Database");

    // determine number of columns
    try {
      return metaData.getColumnCount();
    } // end try
    catch (SQLException sqlException) {
      sqlException.printStackTrace();
    } // end catch

    return 0; // if problems occur above, return 0 for number of columns
  } // end method getColumnCount

  // get name of a particular column in ResultSet
  public String getColumnName(int column) throws IllegalStateException {
    // ensure database connection is available
    if (!connectedToDatabase)
      throw new IllegalStateException("Not Connected to Database");

    // determine column name
    try {
      return metaData.getColumnName(column + 1);
    } // end try
    catch (SQLException sqlException) {
      sqlException.printStackTrace();
    } // end catch

    return ""; // if problems, return empty string for column name
  } // end method getColumnName

  // return number of rows in ResultSet
  public int getRowCount() throws IllegalStateException {
    // ensure database connection is available
    if (!connectedToDatabase)
      throw new IllegalStateException("Not Connected to Database");

    return numberOfRows;
  } // end method getRowCount



  // obtain value in particular row and column
  public Object getValueAt(int row, int column) throws IllegalStateException {
    // ensure database connection is available
    if (!connectedToDatabase)
      throw new IllegalStateException("Not Connected to Database");

    // obtain a value at specified ResultSet row and column
    try {
      resultSet.next(); /* fixes a bug in MySQL/Java with date format */
      resultSet.absolute(row + 1);
      return resultSet.getObject(column + 1);
    } // end try
    catch (SQLException sqlException) {
      sqlException.printStackTrace();
    } // end catch

    return ""; // if problems, return empty string object
  } // end method getValueAt


  // set new database query string
  public void setQuery(String query) throws SQLException, IllegalStateException {
 // ensure database connection is available
    if (!connectedToDatabase)
      throw new IllegalStateException("Not Connected to Database");

    // close previous ResultSet if exists
    if (resultSet != null) {
      resultSet.close();
    }

    // specify query and execute it
    resultSet = statement.executeQuery(query);

    // obtain meta data for ResultSet
    metaData = resultSet.getMetaData();

    // determine number of rows in ResultSet
    resultSet.last(); // move to last row
    numberOfRows = resultSet.getRow(); // get row number

    // notify JTable that model has changed
    fireTableStructureChanged();
  } // end method setQuery

  // set new database update-query string
  public int setUpdate(String query) throws SQLException, IllegalStateException {
    int res;
    // ensure database connection is available
    if (!connectedToDatabase)
      throw new IllegalStateException("Not Connected to Database");

    // specify query and execute it
    res = statement.executeUpdate(query);
    
    /*
     * // obtain meta data for ResultSet metaData = resultSet.getMetaData(); // determine number of
     * rows in ResultSet resultSet.last(); // move to last row numberOfRows = resultSet.getRow(); //
     * get row number
     */
    // notify JTable that model has changed
  //fireTableStructureChanged();
  return res;
  } // end method setUpdate


  public void disconnectFromDatabase() {
    if (!connectedToDatabase)
      return;
    // close Statement and Connection
    else
      try {
        statement.close();
        connection.close();
      } // end try
      catch (SQLException sqlException) {
        sqlException.printStackTrace();
      } // end catch
      finally // update database connection status
      {
        connectedToDatabase = false;
      } // end finally
  } // end method disconnectFromDatabase
}
