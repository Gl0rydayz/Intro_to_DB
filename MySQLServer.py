#!/usr/bin/env python3
"""
MySQL Database Creation Script for ALX Book Store
This script creates the alx_book_store database in MySQL server.
"""

import mysql.connector

def create_database():
    """
    Create the alx_book_store database in MySQL server.
    """
    connection = None
    
    try:
        # Connect to MySQL server (without specifying a database)
        connection = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",  # Add your MySQL password here if needed
            port=3306
        )
        
        if connection.is_connected():
            cursor = connection.cursor()
            
            # Create database if it doesn't exist
            cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")
            
            print("Database 'alx_book_store' created successfully!")
            
            # Close cursor
            cursor.close()
            
    except mysql.connector.Error as e:
        print(f"Error connecting to MySQL: {e}")
        print("Please check your MySQL server connection and credentials.")
        
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        
    finally:
        # Close database connection
        if connection and connection.is_connected():
            connection.close()
            print("MySQL connection closed.")

def main():
    """
    Main function to execute the database creation.
    """
    print("Connecting to MySQL server...")
    print("Attempting to create database 'alx_book_store'...")
    print("-" * 50)
    
    create_database()
    
    print("-" * 50)
    print("Script execution completed.")

if __name__ == "__main__":
    main()
