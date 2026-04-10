# Изведете командата на най-стария процес

ps -e -o cmd= --sort=-etime | head -n 1