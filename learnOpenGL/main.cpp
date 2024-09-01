#include<iostream>
#include<glad/glad.h>
#include<GLFW/glfw3.h>

void framebuffer_size_callback(GLFWwindow* window, int width, int height) {
	glViewport(0, 0, width, height);
}

void processInput(GLFWwindow* window)
{
	if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
		glfwSetWindowShouldClose(window, true);
	}
}

void render() {
	glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
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
	glfwWindowHint(GLFW_RESIZABLE, GL_FALSE);
	// Интересно что настраивается через функцию с параметрами key, value

#ifdef __APPLE__
	glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
#endif

	// Создание объекта окна
	GLFWwindow* window = glfwCreateWindow(800, 600, "LearnOpenGL", nullptr, nullptr);
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


	// TODO: проверить что за (GLADloadproc)glfwGetProcAddress
	if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
		std::cout << "Не получилось инициализировать ебучий GLAD" << std:: endl;
		return -1;
	}

	while (!glfwWindowShouldClose(window)) {
		processInput(window);

		render();

		glfwSwapBuffers(window);
		glfwPollEvents();
	}

	glfwTerminate();
	return 0;
}