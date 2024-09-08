#include<iostream>
#include <vector>

#include<glad/glad.h>
#include<GLFW/glfw3.h>

const unsigned int WIDTH = 800;
const unsigned int HEIGHT = 600;

//  Координаты треугольника
const float firstTriangle[] = {
	-0.5f, 0.0f, 0.0f, // Left  
	 0.5f, 0.0f, 0.0f, // Right 
	 0.0f, 0.5f, 0.0f  // Top
};

const float secondTriangle[] = {
	-0.5f,  0.0f, 0.0f, // Left  
	 0.5f,  0.0f, 0.0f, // Right 
	 0.0f, -0.5f, 0.0f  // Top  
};


const char* fragmentShader1Source = "#version 460 core\n"
"out vec4 color;\n"
"void main()\n"
"{\n"
"	color = vec4(1.0f, 0.5f, 0.2f, 1.0f);\n"
"}\n\0";
const GLchar* fragmentShader2Source = "#version 460 core\n"
"out vec4 color;\n"
"void main()\n"
"{\n"
"color = vec4(1.0f, 1.0f, 0.0f, 1.0f); // The color yellow \n"
"}\n\0";

void framebuffer_size_callback(GLFWwindow* window, int width, int height) {
	glViewport(0, 0, width, height);
}

void key_callback(GLFWwindow* window, int key, int scancode, int action, int mode)
{
	if (key == GLFW_KEY_ESCAPE && action == GLFW_PRESS)
		glfwSetWindowShouldClose(window, GL_TRUE);
}


std::vector<GLuint> buildAndCompileShader() {
	// Build and compile our shader program
	// Vertex shader
	GLuint vertexShader = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
	glCompileShader(vertexShader);
	// Fragment shader
	GLuint fragmentShaderOrange = glCreateShader(GL_FRAGMENT_SHADER); // The first fragment shader that outputs the color orange
	GLuint fragmentShaderYellow = glCreateShader(GL_FRAGMENT_SHADER); // The second fragment shader that outputs the color yellow
	GLuint shaderProgramOrange = glCreateProgram();
	GLuint shaderProgramYellow = glCreateProgram(); // The second shader program

	glShaderSource(fragmentShaderOrange, 1, &fragmentShader1Source, NULL);
	glCompileShader(fragmentShaderOrange);
	glShaderSource(fragmentShaderYellow, 1, &fragmentShader2Source, NULL);
	glCompileShader(fragmentShaderYellow);

	// Link shaders
	glAttachShader(shaderProgramOrange, vertexShader);
	glAttachShader(shaderProgramOrange, fragmentShaderOrange);
	glLinkProgram(shaderProgramOrange);

	glAttachShader(shaderProgramYellow, vertexShader);
	glAttachShader(shaderProgramYellow, fragmentShaderYellow);
	glLinkProgram(shaderProgramYellow);

	// remove shaders from CPU/ram
	glDeleteShader(vertexShader);
	glDeleteShader(fragmentShaderOrange);
	glDeleteShader(fragmentShaderYellow);  // Исправлено удаление шейдера, а не программы

	GLuint VBOs[2], VAOs[2];
	glGenVertexArrays(2, VAOs);
	glGenBuffers(2, VBOs);

	// ================================
	// First Triangle setup
	// ===============================
	glBindVertexArray(VAOs[0]);
	glBindBuffer(GL_ARRAY_BUFFER, VBOs[0]);
	glBufferData(GL_ARRAY_BUFFER, sizeof(firstTriangle), firstTriangle, GL_STATIC_DRAW);
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), (GLvoid*)0); // Vertex attributes stay the same
	glEnableVertexAttribArray(0);
	glBindVertexArray(0);

	// ================================
	// Second Triangle setup
	// ===============================
	glBindVertexArray(VAOs[1]);  // Note that we bind to a different VAO now
	glBindBuffer(GL_ARRAY_BUFFER, VBOs[1]);  // And a different VBO
	glBufferData(GL_ARRAY_BUFFER, sizeof(secondTriangle), secondTriangle, GL_STATIC_DRAW);
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, (GLvoid*)0);  // Because the vertex data is tightly packed we can also specify 0 as the vertex attribute's stride to let OpenGL figure it out.
	glEnableVertexAttribArray(0);
	glBindVertexArray(0);

	// Return a single vector containing all GLuints (VBOs, VAOs, and shaders)
	return { VBOs[0], VBOs[1], VAOs[0], VAOs[1], shaderProgramOrange, shaderProgramYellow };
}

void render(GLFWwindow* window, std::vector<GLuint> shaders) {
	// GLuint VBOs = shaders[0];
	GLuint VAO1 = shaders[2];
	GLuint VAO2 = shaders[3];
	GLuint shaderProgramOrange = shaders[4];
	GLuint shaderProgramYellow = shaders[5];
	// Clear the colorbuffer
	glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);

	glUseProgram(shaderProgramOrange);
	glBindVertexArray(VAO1);
	glDrawArrays(GL_TRIANGLES, 0, 3);

	glUseProgram(shaderProgramYellow);
	glBindVertexArray(VAO2);
	glDrawArrays(GL_TRIANGLES, 0, 3);

	// отвязка текущей вершины
	glBindVertexArray(0);

	// Swap the screen buffers
	glfwSwapBuffers(window);
}

int main() {
	setlocale(LC_ALL, "Rus");
	
	// Инициализация GLFW
	glfwInit();

	// Настройка GLFW
	// Задается минимальная требуемая версия OpenGL
	// Нужная мажорная версия
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 4);
	// Нужная минорная версия
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 6);
	// Установка профайла для которого создается контекст
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
	// Запрещаем менять окно
	glfwWindowHint(GLFW_RESIZABLE, GL_TRUE);
	// Интересно что настраивается через функцию с параметрами key, value

#ifdef __APPLE__
	glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
#endif

	// Создание объекта окна
	GLFWwindow* window = glfwCreateWindow(WIDTH, HEIGHT, "LearnOpenGL", nullptr, nullptr);
	if (window == nullptr)
	{
		std::cout << "Failed to create GLFW window" << std::endl;
		// Отменяем glfw и закрываем приложение с ошибкой
		glfwTerminate();
		return -1;
	}
	// Создание контекста окна
	glfwMakeContextCurrent(window);
	glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

	// устанавливаем слушателя на ввод
	glfwSetKeyCallback(window, key_callback);


	// TODO: проверить что за (GLADloadproc)glfwGetProcAddress
	if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
		std::cout << "Не получилось инициализировать ебучий GLAD" << std:: endl;
		return -1;
	}

	std::vector<GLuint> shaders = buildAndCompileShader();
	GLuint VBO = shaders[0];
	GLuint VAO = shaders[1];

	while (!glfwWindowShouldClose(window)) {
		// Check if any events have been activiated (key pressed, mouse moved etc.) and call corresponding response functions
		glfwPollEvents();

		render(window, shaders);

	}

	// Properly de-allocate all resources once they've outlived their purpose
	glDeleteVertexArrays(1, &VAO);
	glDeleteBuffers(1, &VBO);

	glfwTerminate();
	return 0;
}