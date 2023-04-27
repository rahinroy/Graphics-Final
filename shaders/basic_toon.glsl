// Floors rgb values to create groups of aligned color for cell shading 
void main()
{
	float4 c0 = Sample();

	float factor = 5;
    float red    = (floor(c0.r * factor) / factor);
    float green  = (floor(c0.g * factor) / factor);
    float blue   = (floor(c0.b * factor) / factor);

	SetOutput(float4(red, green, blue, c0.a));
}