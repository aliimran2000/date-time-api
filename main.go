package main

import (
	"time"

	"github.com/gin-gonic/gin"
)

func getCurrentDateTime() gin.H {
	return gin.H{
		"current_time": time.Now().Format(time.RFC3339),
	}
}

func main() {
	r := gin.Default()

	r.GET("/datetime", func(c *gin.Context) {
		c.JSON(200, getCurrentDateTime())
	})

	r.Run(":8080")
}
