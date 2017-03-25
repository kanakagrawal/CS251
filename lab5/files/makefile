CC  = g++
TARGET = out

CPPS := $(wildcard *.cpp)
OBJS := $(CPPS:%.cpp=%.o)

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) -o $@ $(OBJS)

-include $(OBJS:.o=.d)

$(OBJS): %.o : %.cpp
	$(CC) -MMD -c $< -o $@ 

clean:
	rm -rf *.o out *.d *~