#include <gtest/gtest.h>
#include <numeric>
#include <vector>
#include <stdlib.h>

TEST(BasicTest, Sum)
{
    std::vector<int> vec{1, 2, 3, 4, 5};
    int sum= std::accumulate(vec.begin(), vec.end(), 0);
    EXPECT_EQ(sum, 15);
}

int main(int argc, char *argc[])
{
    ::testing::InitGoogle(&argc, argv);
    ::testing::AddGlobalTestEnvironment(new TestEnvironment);
    return RUN_ALL_TESTS();
}