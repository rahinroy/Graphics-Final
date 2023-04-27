// basic depth blur 
// calculates a blurred version of the pixel and linearly interpolates
// between the original and blurred version based on depth

void main()
{
    float depth = SampleDepth();
    float max_depth = SampleDepthLocation(float2(1, 1));
    float min_depth = SampleDepthLocation(float2(0.5, 0.1));

    depth = clamp((depth - min_depth) / (max_depth - min_depth), 0.0, 1.0);
    float4 c0 = Sample();
	float2 sample_dist = GetInvResolution() * 5;
	float2 pos = GetCoordinates();
	float4 color1 = SampleLocation(pos + sample_dist * float2(-1, -1));
	float4 color2 = SampleLocation(pos + sample_dist * float2(1, -1));
	float4 color3 = SampleLocation(pos + sample_dist * float2(1, 1));
	float4 color4 = SampleLocation(pos + sample_dist * float2(-1, 1));
	float4 blurred = (color1 + color2 + color3 + color4 + c0) / 5.0;
	SetOutput(lerp(c0, blurred, depth));

}