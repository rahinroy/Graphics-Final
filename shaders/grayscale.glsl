
void main()
{
	float4 c0 = Sample();
    // RGB multiplcication factors to get accurate grayscale on old tvs 
    SetOutput(dot(c0, float4(0.3, 0.59, 0.11. 0.0)));
}